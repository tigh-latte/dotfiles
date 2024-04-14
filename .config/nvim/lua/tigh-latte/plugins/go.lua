return {
	"ray-x/go.nvim",
	dependencies = {
		"ray-x/guihua.lua",
		"neovim/nvim-lspconfig",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		-- Disable all the lsp stuff as the LSP is already configured in this setup.
		require("go").setup({
			lsp_codelens = false,
			lsp_inlay_hints = {
				enable = false,
			},
		})

		local opts = { remap = false, buffer = true, silent = true }
		vim.keymap.set("n", "<Leader>gcc", ":GoCoverage<CR>", opts)
		vim.keymap.set("n", "<Leader>gaa", ":GoAltV<CR>", opts)
		vim.keymap.set("n", "<Leader>gtt", ":GoTest<CR>", opts)
		vim.keymap.set("n", "<Leader>gtf", ":GoTestFunc<CR>", opts)
	end,
	event = { "CmdlineEnter" },
	ft = { "go", "gomod" },
	build = ':lua require("go.install").update_all_sync()',
}
