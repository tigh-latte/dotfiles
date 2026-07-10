local methods = vim.lsp.protocol.Methods

return function()
	---@param err lsp.ResponseError?
	local cb = function(err)
		if err == nil then return end
		vim.notify(err.message, vim.log.levels.ERROR)
		error(err)
	end

	---@param err lsp.ResponseError?
	local cb_restart = function(err)
		cb(err)
		vim.defer_fn(function()
			vim.cmd.lsp("restart gopls")
		end, 500)
	end

	local function alt_name()
		local bname = vim.fn.bufname()
		local is_test = not bname:match("_test.go$")

		return is_test
			and bname:gsub(".go$", "_test.go")
			or bname:gsub("_test.go$", ".go")
	end

	---@return vim.lsp.Client
	local function get_client()
		local client = vim.lsp.get_clients({ name = "gopls" })
		assert(client and #client > 0, "gopls isn't running")
		return client[1]
	end

	vim.api.nvim_buf_create_user_command(0, "GoModTidy", function()
		get_client():request("workspace/executeCommand", {
			command = "gopls.tidy",
			arguments = { { URIs = { vim.uri_from_bufnr(0) } } },
		}, cb_restart)
	end, { nargs = 0 })

	vim.api.nvim_buf_create_user_command(0, "GoModVendor", function()
		get_client():request("workspace/executeCommand", {
			command = "gopls.vendor",
			arguments = { { URI = vim.uri_from_bufnr(0) } },
		}, cb_restart)
	end, { nargs = 0 })

	vim.api.nvim_buf_create_user_command(0, "GoGenerate", function()
		local client = get_client()
		assert(#client.workspace_folders > 0)
		local u = client.workspace_folders[1].uri

		client:request("workspace/executeCommand", {
			command = "gopls.generate",
			arguments = {
				{ dir = u, recursive = true },
			},
		}, cb_restart)
	end, { nargs = 0 })

	vim.api.nvim_buf_create_user_command(0, "GoTestFunc", function()
		local bname = vim.fn.bufname()
		if not bname:match("_test.go$") then
			vim.notify("not in test file", vim.log.levels.ERROR)
		end

		local parsed = assert(vim.treesitter.get_parser():parse())
		local cur_name = vim.treesitter.get_node()

		while cur_name and cur_name:type() ~= "function_declaration" do
			cur_name = cur_name:parent()
		end

		local _do = function(fn_name)
			if not fn_name then return end
			local arguments = { URI = vim.uri_from_bufnr(0) }
			local prefix_test = "Test"
			local prefix_bench = "Benchmark"

			if fn_name:sub(1, #prefix_test) == prefix_test then
				arguments.tests = { fn_name }
			elseif fn_name:sub(1, #prefix_bench) == prefix_bench then
				arguments.benchmarks = { fn_name }
			else
				vim.notify("not a test function", vim.log.levels.ERROR)
			end

			local client = get_client()
			client:request("workspace/executeCommand", {
				command = "gopls.run_tests",
				arguments = { arguments },
			}, cb)
		end

		if cur_name then
			local test_fn = cur_name:field("name")
			assert(test_fn and #test_fn > 0, "function doesn't have a name?")
			test_fn = test_fn[1]
			local line, char, eline, echar = test_fn:range()
			local fname = vim.api.nvim_buf_get_text(0, line, char, eline, echar, {})[1]

			_do(fname)
		else
			local root = parsed[1]:root()
			local query = vim.treesitter.query.parse("go", [[
				(source_file [
					(function_declaration
						name: (_) @__test (#match? @__test "^Test")
						parameters: (_
							(parameter_declaration
								type: (pointer_type) @__ttype (#eq? @__ttype "*testing.T"))))

					(function_declaration
						name: (_) @__bench (#match? @__bench "^Benchmark")
						parameters: (_
							(parameter_declaration
								type: (pointer_type) @__btype (#eq? @__btype "*testing.B"))))
				])
			]])

			local fns = {}
			for id, node in query:iter_captures(root, 0) do
				if not vim.tbl_contains({ "__test", "__bench" }, query.captures[id]) then goto continue end

				local line, char, eline, echar = node:range()
				local name = vim.api.nvim_buf_get_text(0, line, char, eline, echar, {})[1]

				table.insert(fns, name)

				::continue::
			end

			vim.ui.select(fns, { prompt = "Test to run:" }, _do)
		end
	end, { nargs = 0 })

	vim.api.nvim_buf_create_user_command(0, "GoTestFile", function()
		local bname = vim.fn.bufname()
		if not bname:match("_test.go$") then vim.notify("not in test file", vim.log.levels.ERROR) end

		local root = vim.treesitter.get_parser():parse()[1]:root()
		local query = vim.treesitter.query.parse("go", [[
			(source_file [
				(function_declaration
					name: (_) @__test (#match? @__test "^Test")
					parameters: (_
						(parameter_declaration
							type: (pointer_type) @__ttype (#eq? @__ttype "*testing.T"))))

				(function_declaration
					name: (_) @__bench (#match? @__bench "^Benchmark")
					parameters: (_
						(parameter_declaration
							type: (pointer_type) @__btype (#eq? @__btype "*testing.B"))))
			])
		]])

		local tests = { __test = {}, __bench = {} }

		for id, node in query:iter_captures(root, 0) do
			if not vim.tbl_contains({ "__test", "__bench" }, query.captures[id]) then goto continue end

			local line, char, eline, echar = node:range()
			local name = vim.api.nvim_buf_get_text(0, line, char, eline, echar, {})[1]

			table.insert(tests[query.captures[id]], name)

			::continue::
		end

		local client = get_client()
		client:request("workspace/executeCommand", {
			command = "gopls.run_tests",
			arguments = { {
				URI = vim.uri_from_bufnr(0),
				tests = tests.__test,
				benchmarks = tests.__bench,
			} },
		}, cb)
	end, { nargs = 0 })

	vim.api.nvim_buf_create_user_command(0, "GoGet", function(args)
		local pkg = args.args
		if pkg == "" then
			local _ = vim.treesitter.get_parser():parse()
			local node = vim.treesitter.get_node()
			if node == nil then
				vim.notify("could not find treesitter node", vim.log.levels.ERROR)
				return
			end
			if node:type() == "interpreted_string_literal" then
				node = node:child(1)
				if node == nil then
					vim.notify("could not find content of string literal", vim.log.levels.ERROR)
					return
				end
			end

			if node:type() ~= "interpreted_string_literal_content" then
				vim.notify("no package given", vim.log.levels.ERROR)
				return
			end

			local line, char, eline, echar = node:range()
			pkg = vim.api.nvim_buf_get_text(0, line, char, eline, echar, {})[1]
		end

		local client = get_client()
		client:request("workspace/executeCommand", {
			command = "gopls.go_get_package",
			arguments = { {
				URI = vim.uri_from_bufnr(0),
				pkg = pkg,
				addRequire = false,
			} },
		}, cb)
	end, { nargs = "?" })

	vim.api.nvim_buf_create_user_command(0, "GoAltV", function()
		vim.cmd.vsplit(alt_name())
	end, { nargs = 0 })

	vim.api.nvim_buf_create_user_command(0, "GoAltH", function()
		vim.cmd.split(alt_name())
	end, { nargs = 0 })

	vim.api.nvim_buf_create_user_command(0, "GoAlt", function()
		vim.cmd.e(alt_name())
	end, { nargs = 0 })

	vim.api.nvim_buf_create_user_command(0, "GoImpl", function()
		local cur_name = vim.treesitter.get_node()
		while cur_name and cur_name:type() ~= "type_declaration" do
			cur_name = cur_name:parent()
		end
		if not cur_name then
			vim.notify("no type under cursor", vim.log.levels.ERROR)
			return
		end
		cur_name = cur_name:child(1)
		local line, char, eline, echar = cur_name:range()

		local _do = function(iface_name)
			get_client():request(methods.workspace_executeCommand, {
				command = "gopls.implement_interface",
				arguments = { {
					location = {
						uri = vim.uri_from_bufnr(0),
						range = {
							start = { line = line, character = char },
							["end"] = { line = eline, character = echar },
						},
					},
					interface = iface_name, -- defined in gopls but not needed. sending anyway.
				} },
				formFields = { { ["type"] = "string" } },
				formAnswers = { iface_name },
			}, cb_restart)
		end

		local previewer = require("fzf-lua.previewer.builtin").buffer_or_file:extend()
		function previewer:new(o, _opts, fzf_win)
			previewer.super.new(self, o, _opts, fzf_win)
			setmetatable(self, previewer)
			return self
		end

		function previewer:parse_entry(entry_str)
			if not self.results then return end
			local entry = self.results[entry_str]
			if not entry or entry == "" then return end
			return {
				path = vim.uri_to_fname(entry.location.uri),
				line = entry.location.range.start.line + 1,
				col = entry.location.range.start.character + 1,
			}
		end

		local last_request_id
		---@return lsp.Handler
		local function build_lsp_handler(handle)
			return function(err, results)
				(function()
					last_request_id = nil
					if err ~= nil then
						vim.notify(err.message, vim.log.levels.ERROR)
						return
					end
					if results == nil then
						return
					end

					previewer.results = {}

					for _, result in ipairs(results) do
						if vim.lsp.protocol.SymbolKind[result.kind] ~= "Interface" then
							goto continue
						end

						local key = (function()
							if not result.containerName:find "/" then
								return result.name
							end
							-- here, the result.containerName is the package path (github.com/blahblah/blah)
							-- and the result.name is the interface name. However, the inferface name can
							-- _sometimes_ contain the package name (blah.Blaher).
							-- In this case, a direct combine would create
							-- github.com/blahblah/blah.blah.Blaher
							-- To prevent this, we check if result.name has a ".", and if yes, cut everyting
							-- before it
							local name = result.name
							local accessor_idx = result.name:find "%."
							name = accessor_idx and name:sub(accessor_idx + 1) or name

							return result.containerName .. "." .. name
						end)()

						previewer.results[key] = result
						handle(key)

						::continue::
					end
				end)()
			end
		end

		local function generate_contents(query)
			if last_request_id then get_client():cancel_request(last_request_id) end
			return function(handle)
				query = (query and query[1]) or ""
				_, last_request_id = get_client():request(
					methods.workspace_symbol,
					{ query = query },
					build_lsp_handler(handle)
				)
			end
		end

		require("fzf-lua").fzf_live(generate_contents, {
			prompt = "Find an interface > ",
			actions = {
				default = function(items)
					if not items or #items == 0 then return end
					local item = items[1]
					_do(item)
				end
			},
			previewer = previewer,
		})
	end, { nargs = 0 })

	local opts = { remap = false, buffer = true, silent = true }
	vim.keymap.set("n", "<Leader>gav", vim.cmd.GoAltV, opts)
	vim.keymap.set("n", "<Leader>gaa", vim.cmd.GoAltH, opts)
	vim.keymap.set("n", "<Leader>ga.", vim.cmd.GoAlt, opts)
	vim.keymap.set("n", "<Leader>gtf", vim.cmd.GoTestFunc, opts)
	vim.keymap.set("n", "<Leader>gtt", vim.cmd.GoTestFile, opts)
	vim.keymap.set("n", "<Leader>gmt", vim.cmd.GoModTidy, opts)
	vim.keymap.set("n", "<Leader>gmv", vim.cmd.GoModVendor, opts)
	vim.keymap.set("n", "<Leader>gen", vim.cmd.GoGenerate, opts)
	vim.keymap.set("n", "<Leader>gg", vim.cmd.GoGet, opts)
	vim.keymap.set("n", "<Leader>gim", vim.cmd.GoImpl, opts)

	vim.cmd.compiler "go"
end
