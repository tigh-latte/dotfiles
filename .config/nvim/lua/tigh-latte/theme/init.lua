local M = {
	highlights = vim.tbl_deep_extend(
		"error",
		require("tigh-latte.theme.cmp"),
		require("tigh-latte.theme.vimui"),
		require("tigh-latte.theme.treesitter"),
		require("tigh-latte.theme.telescope"),
		require("tigh-latte.theme.fzf"),
		require("tigh-latte.theme.lsp"),
		require("tigh-latte.theme.cucumber"),
		require("tigh-latte.theme.fugitive"),
		require("tigh-latte.theme.langs")
	),
}

function M.colorscheme()
	for group, highlight in pairs(M.highlights) do
		vim.api.nvim_set_hl(0, group, highlight)
	end
end

return M
