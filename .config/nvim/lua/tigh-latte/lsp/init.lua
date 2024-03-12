local M = {}

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

M.on_attach = function(_, bufnr)
	require("lsp_signature").on_attach({
		bind = true,
		doc_lines = 0,
		handler_opts = {
			border = "none",
		},
		hint_enable = false,
	}, bufnr)

	local opts = { buffer = bufnr, remap = false }

	vim.keymap.set("n", "<Leader>cdd", vim.lsp.buf.definition, opts)

	local telescope = require("telescope.builtin")

	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "<Leader>cref", telescope.lsp_references, opts)
	vim.keymap.set("n", "<Leader>/", telescope.lsp_dynamic_workspace_symbols, opts)
	vim.keymap.set("n", "<Leader>cren", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "<Leader>cp", vim.diagnostic.goto_prev, opts)
	vim.keymap.set("n", "<Leader>cn", vim.diagnostic.goto_next, opts)
	vim.keymap.set("n", "<Leader>cee", vim.diagnostic.open_float, opts)
	vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)

	vim.keymap.set("n", "<Leader>csq", vim.lsp.buf.workspace_symbol, opts)
end

return M
