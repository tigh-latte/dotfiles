return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = { run = ":TSUpdate" },
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"go",
					"lua",
					"vim",
					"vimdoc",
					"query",
					"typescript",
					"python",
					"make",
				},
				ignore_install = {},
				modules = {},
				sync_install = false,
				auto_install = true,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = true,
				},
			})
		end,
	},
	{
		"nvim-treesitter/playground",
	},
}
