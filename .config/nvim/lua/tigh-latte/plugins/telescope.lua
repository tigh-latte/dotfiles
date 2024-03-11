return {
	"nvim-telescope/telescope.nvim",
	depends = {
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
				},
				vimgrep_arguments = {
					"rg",
					"-uuu",
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
				},
			},
			pickers = {
				lsp_references = {
					theme = "ivy",
				},
				find_files = {
					hidden = true,
					sorting_strategy = "descending",
					layout_config = {
						prompt_position = "bottom",
					},
				},
			},
		})

		local builtin = require("telescope.builtin")

		vim.keymap.set("n", "<C-P>", builtin.find_files, { silent = true })
		vim.keymap.set("n", "<M-/>", builtin.live_grep, { silent = true })
	end,
}
