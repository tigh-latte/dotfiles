return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		require("telescope").setup({
			defaults = {
				file_ignore_patterns = {
					"node_modules",
					"vendor",
					"target",
					"dist",
					"build/",
					"*.min.*",
					".git/",
					".venv/",
				},
				vimgrep_arguments = {
					"rg",
					"--hidden",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
					"--glob=!/**/vendor/*",
					"--glob=!/**/node_modules/*",
					"--glob=!/**/.git/*",
					"--glob=!/**/.gitmodules",
					"--glob=!/**/.venv/*",
				},
			},
			pickers = {
				lsp_references = {
					theme = "ivy",
				},
				find_files = {
					hidden = true,
					no_ignore = true,
					sorting_strategy = "descending",
					layout_config = {
						prompt_position = "bottom",
					},
				},
			},
		})

		local builtin = require("telescope.builtin")

		vim.keymap.set("n", "<C-P>", builtin.find_files, { silent = true })
		vim.keymap.set("n", "<Leader>grep", builtin.live_grep, { silent = true }) -- consider a handier binding.
		vim.keymap.set("n", "<Leader>cb", builtin.git_branches, { silent = true })
	end,
}
