local M = {}

M.setup = function()
	vim.opt.completeopt = { "menuone", "noselect", "noinsert", "preview" }

	require("tigh-latte.lsp.cmp").setup()
	require("tigh-latte.lsp.lang")

	local signs = { Error = "😱", Warn = "🤔", Hint = "", Info = "" }
	for type, icon in pairs(signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
	end

	vim.api.nvim_set_hl(0, "DiagnosticWarn", { ctermfg = 172 })

	vim.diagnostic.config({
		virtual_text = {
			prefix = "•",
		},
	})
end

return M
