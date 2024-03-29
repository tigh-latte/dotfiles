local M = {}

local default_opts = {
	format_func = function() vim.lsp.buf.format() end,
}

M.setup = function()
	vim.opt.completeopt = { "menuone", "noselect", "noinsert", "preview" }

	M.lsp_group = vim.api.nvim_create_augroup("tigh-latte-lsp", {
		clear = false,
	})

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

		vim.keymap.set("n", "<Leader>cdd", vim.lsp.buf.definition, kmopts)

		local telescope = require("telescope.builtin")

		vim.keymap.set("n", "K", vim.lsp.buf.hover, kmopts)
		vim.keymap.set("n", "<Leader>cref", telescope.lsp_references, kmopts)
		vim.keymap.set("n", "<Leader>/", telescope.lsp_dynamic_workspace_symbols, kmopts)
		vim.keymap.set("n", "<Leader>cren", vim.lsp.buf.rename, kmopts)
		vim.keymap.set("n", "<Leader>cp", vim.diagnostic.goto_prev, kmopts)
		vim.keymap.set("n", "<Leader>cn", vim.diagnostic.goto_next, kmopts)
		vim.keymap.set("n", "<Leader>cee", vim.diagnostic.open_float, kmopts)
		vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, kmopts)
		vim.keymap.set("n", "<Leader>csq", vim.lsp.buf.workspace_symbol, kmopts)

		vim.api.nvim_create_autocmd("BufWritePre", {
			group = vim.api.nvim_create_augroup("tigh-latte-lsp", {
				clear = false,
			}),
			buffer = bufnr,
			callback = opts.format_func,
		})
	end
end

return M
