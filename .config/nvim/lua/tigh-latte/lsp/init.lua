local M = {}

---@class tigh-latte.lsp.opts
---@field on_save_actions? string[]
local default_opts = {
	on_save_actions = {},
}

M.setup = function()
	vim.opt.completeopt = { "menuone", "noselect", "noinsert", "preview" }

	require("tigh-latte.lsp.cmp")
	require("tigh-latte.lsp.lang")

	local signs = { Error = "•", Warn = "•", Hint = "•", Info = "•" }
	for type, icon in pairs(signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
	end

	vim.diagnostic.config({
		virtual_text = {
			prefix = "•",
		},
	})
end

-- Create an on_attach function with the option to override, for now,
-- just the default formatter.
---@param opts? tigh-latte.lsp.opts
M.make_on_attach = function(opts)
	if opts == nil then
		opts = {}
	end
	opts = vim.tbl_extend("force", default_opts, opts)

	return function(_, bufnr)
		require("lsp_signature").on_attach({
			bind = true,
			doc_lines = 0,
			handler_opts = {
				border = "none",
			},
			hint_enable = false,
		}, bufnr)

		local kmopts = { buffer = bufnr, remap = false }

		vim.keymap.set("n", "<Leader>cd", vim.lsp.buf.definition, kmopts)

		local telescope = require("telescope.builtin")

		vim.keymap.set("n", "K", vim.lsp.buf.hover, kmopts)
		vim.keymap.set("n", "<Leader>cref", telescope.lsp_references, kmopts)
		vim.keymap.set("n", "<Leader>/", telescope.lsp_dynamic_workspace_symbols, kmopts)
		vim.keymap.set("n", "<Leader>cren", vim.lsp.buf.rename, kmopts)
		vim.keymap.set("n", "<Leader>cp", vim.diagnostic.goto_prev, kmopts)
		vim.keymap.set("n", "<Leader>cn", vim.diagnostic.goto_next, kmopts)
		vim.keymap.set("n", "<Leader>ce", vim.diagnostic.open_float, kmopts)
		vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, kmopts)
		vim.keymap.set("n", "<Leader>csq", vim.lsp.buf.workspace_symbol, kmopts)
		vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, kmopts)
		vim.keymap.set("n", "<Leader>cim", vim.lsp.buf.implementation, kmopts)
		vim.keymap.set("n", "<Leader>hi", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
		end, kmopts)

		-- Autoformat on save.
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = vim.api.nvim_create_augroup("tigh-latte-lsp", {
				clear = false,
			}),
			buffer = bufnr,
			callback = function()
				for _, action in ipairs(opts.on_save_actions) do
					local params = vim.lsp.util.make_range_params()
					params.context = { only = { action } }
					local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
					for cid, res in pairs(result or {}) do
						for _, r in pairs(res.result or {}) do
							if r.edit then
								local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
								vim.lsp.util.apply_workspace_edit(r.edit, enc)
							elseif r.command then
								local command = type(r.command) == "table" and r.command or r
								vim.lsp.buf.execute_command(command)
							end
						end
					end
				end
				vim.lsp.buf.format({ async = false })
			end,
		})
	end
end

return M
