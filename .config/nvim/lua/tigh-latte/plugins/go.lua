return {
	"ray-x/go.nvim",
	dependencies = {
		"ray-x/guihua.lua",
		"neovim/nvim-lspconfig",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("go").setup({
			lsp_codelens = false,
			lsp_inlay_hints = {
				enable = false,
			},
		})
		vim.keymap.set("n", "<Leader>gcc", ":GoCoverage<CR>", { noremap = true, silent = true })
		vim.keymap.set("n", "<Leader>gaa", ":GoAltV<CR>", { noremap = true, silent = true })
		vim.keymap.set("n", "<Leader>gtt", ":GoTest<CR>", { noremap = true, silent = true })
		vim.keymap.set("n", "<Leader>gtf", ":GoTestFunc<CR>", { noremap = true, silent = true })
	end,
	event = { "CmdlineEnter" },
	ft = { "go", "gomod" },
	build = ':lua require("go.install").update_all_sync()',
}
