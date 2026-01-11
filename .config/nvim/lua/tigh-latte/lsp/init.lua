local M = {
	group = vim.api.nvim_create_augroup("tigh-latte-lsp", {
		clear = false,
	}),
}

local mthds = require("vim.lsp.protocol").Methods

---@param bufnr integer
---@param actions string|string[]
function M.do_codeaction(bufnr, actions)
	bufnr = bufnr or 0
	actions = type(actions) == "table" and actions or { actions }

	for _, action in ipairs(actions) do
		local params = function(client)
			local p = vim.lsp.util.make_range_params(0, client.offset_encoding)
			---@diagnostic disable-next-line: inject-field
			p.context = { only = { action } }
			return p
		end
		local result = vim.lsp.buf_request_sync(bufnr, mthds.textDocument_codeAction, params)
		for cid, res in pairs(result or {}) do
			for _, r in pairs(res.result or {}) do
				local client = (vim.lsp.get_client_by_id(cid) or {})
				if r.edit then
					local enc = client.offset_encoding or "utf-16"
					vim.lsp.util.apply_workspace_edit(r.edit, enc)
				elseif r.command then
					local command = type(r.command) == "table" and r.command or r
					client:exec_cmd(command)
				end
			end
		end
	end
end

function M.setup()
	vim.api.nvim_create_user_command("LspCodeAction", function(args)
		if args.args == "" then return end
		-- doesn't work with quickfix, not sure why.
		M.do_codeaction(0, args.args)
	end, {
		nargs = 1,
		complete = function(arg)
			local range = vim.lsp.util.make_range_params(0, "utf-16")
			local params = vim.tbl_extend("error", range, {
				context = {
					triggerKind = vim.lsp.protocol.CodeActionTriggerKind.Invoked,
					diagnostics = vim.diagnostic.get(0, {
						lnum = vim.api.nvim_win_get_cursor(0)[1],
					}),
				},
			})


			local results = vim.lsp.buf_request_sync(
				0,
				mthds.textDocument_codeAction,
				params
			)
			if results == nil then
				return nil
			end
			local result = results[1]
			return vim.iter(result.result)
				:map(function(r)
					return r.kind
				end)
				:filter(function(r)
					return r:sub(1, #arg) == arg
				end)
				:totable()
		end,
	})

	for _, mthd in ipairs({ mthds.textDocument_typeDefinition, mthds.textDocument_definition }) do
		M.extend_handler(mthd, function(handler)
			handler()
			vim.api.nvim_feedkeys("zz", "n", false)
		end)
	end

	vim.lsp.config("*", {
		capabilities = vim.lsp.protocol.make_client_capabilities(),
		root_dir = function(bufnr, on_dir)
			local root = vim.fs.root(bufnr, { ".git" })
			on_dir(root or vim.fn.getcwd())
		end,
	})

	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(ev)
			local client = vim.lsp.get_client_by_id(ev.data.client_id)
			if not client then return end
			M.make_on_attach(client, ev.buf)
		end,
	})

	vim.opt.completeopt = { "menuone", "noselect", "noinsert", "preview" }

	vim.diagnostic.config({
		virtual_text = {
			prefix = "•",
		},
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = "•",
				[vim.diagnostic.severity.WARN] = "•",
				[vim.diagnostic.severity.HINT] = "•",
				[vim.diagnostic.severity.INFO] = "•",
			},
		},
	})
end

-- Create an on_attach function with the option to override, for now,
-- just the default formatter.
---@param client vim.lsp.Client
---@param bufnr integer
function M.make_on_attach(client, bufnr)
	local kmopts = { buffer = bufnr, remap = false }

	vim.keymap.set("n", "<Leader>cd", vim.lsp.buf.definition, kmopts)
	vim.keymap.set("n", "<Leader>ct", vim.lsp.buf.type_definition, kmopts)

	vim.keymap.set("n", "K", vim.lsp.buf.hover, kmopts)
	vim.keymap.set("n", "<Leader>crn", vim.lsp.buf.rename, kmopts)
	vim.keymap.set("n", "<Leader>cp", function() vim.diagnostic.jump({ count = -1, float = true }) end, kmopts)
	vim.keymap.set("n", "<Leader>cn", function() vim.diagnostic.jump({ count = 1, float = true }) end, kmopts)
	vim.keymap.set("n", "<Leader>ce", vim.diagnostic.open_float, kmopts)
	vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, kmopts)
	vim.keymap.set("n", "<Leader>csq", vim.lsp.buf.workspace_symbol, kmopts)
	vim.keymap.set("n", "<Leader>crr", vim.lsp.buf.references, kmopts)
	-- vim.keymap.set("n", "<Leader>cim", vim.lsp.buf.implementation, kmopts)
	vim.keymap.set("n", "<Leader>hi", function()
		vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
	end, kmopts)

	vim.api.nvim_buf_create_user_command(bufnr, "LspRestart", function(cmd)
		local clients = cmd.fargs
		if #clients == 0 then
			clients = vim.iter(vim.lsp.get_clients())
				:map(function(c) return c.name end)
				:totable()
		end

		vim.iter(clients):each(function(name)
			local c = vim.lsp.get_clients({ name = name })
			vim.lsp.stop_client(c, true)
			vim.defer_fn(function()
				vim.schedule_wrap(vim.lsp.enable)(name)
			end, 500)
		end)
	end, {
		nargs = "?",
		complete = function(arg)
			return vim.iter(vim.lsp.get_clients())
				:map(function(c) return c.name end)
				:filter(function(name) return name:sub(1, #arg) == arg end)
				:totable()
		end,
	})

	vim.keymap.set("n", "<Leader>lre", vim.cmd.LspRestart, kmopts)

	local on_save_actions = ({
		gopls = { "source.organizeImports" },
		ts_ls = {
			"source.sortImports.ts",
			"source.addMissingImports.ts",
			"source.removeUnusedImports.ts",
		},
	})[client.name]

	vim.api.nvim_create_autocmd("BufWritePre", {
		group = M.group,
		buffer = bufnr,
		callback = function(ev)
			M.do_codeaction(ev.buf, on_save_actions)

			local clients = vim.lsp.get_clients({
				bufnr = bufnr,
				method = mthds.textDocument_formatting,
			})
			if #clients > 0 then
				vim.lsp.buf.format({ async = false })
			end
		end,
	})

	vim.api.nvim_create_autocmd("LspDetach", {
		buffer = bufnr,
		callback = function(ev)
			vim.api.nvim_clear_autocmds({
				buffer = ev.buf,
				group = M.group,
			})
		end,
	})
end

---@param method string
---@param fn fun(handler: fun())
function M.extend_handler(method, fn)
	local handler = require("vim.lsp.handlers")[method]
	require("vim.lsp.handlers")[method] = function(err, result, context, config)
		fn(function()
			handler(err, result, context, config)
		end)
	end
end

return M
