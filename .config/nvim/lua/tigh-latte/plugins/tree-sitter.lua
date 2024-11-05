return {
	{
		dependencies = { "nvim-treesitter/nvim-treesitter-refactor" },
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
					"dockerfile",
				},
				ignore_install = {},
				modules = {},
				sync_install = false,
				auto_install = true,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = true,
				},
				refactor = {
					highlight_definitions = {
						enable = true,
						clear_on_cursor_move = false,
					},
				},
			})

			vim.treesitter.language.register("bash", "zsh")
		end,
	},
	{
		"nvim-treesitter/playground", -- The lord's plugin.
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			require("treesitter-context").setup({
				max_lines = 4,
				multiline_threshold = 4,
			})
		end,
	},
}
