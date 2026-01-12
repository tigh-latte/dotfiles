return function()
	local cb = function(err)
		if err then vim.notify(tostring(err), vim.log.levels.ERROR) end
	end

	local cb_restart = function(err)
		cb(err)
		vim.defer_fn(function()
			vim.cmd.LspRestart("gopls")
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

		local parsed = vim.treesitter.get_parser():parse()
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
end
