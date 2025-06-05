local statusline = os.getenv("NVIM_STATUSLINE")
return {
	{
		"nvim-lualine/lualine.nvim",
		lazy = statusline ~= "lualine",
		config = function()
			require("lualine").setup({
				options = {
					refresh = {
						statusline = 100,
					},
				},
			})
		end,
	},
	{
		"vim-airline/vim-airline",
		lazy = statusline ~= "airline",
		config = function()
			vim.cmd([[
			"let g:airline#extensions#tabline#enabled = 1
			"let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
			let g:airline_mode_map = {
				\ '__': '-',
				\ 'n': 'N',
				\ 'i': 'I',
				\ 'ic': 'IC',
				\ 'R': 'R',
				\ 'c': 'C',
				\ 'v': 'V',
				\ 'V': 'V-LINE',
				\ '': 'V-BLOCK',
				\ 's': 'S',
				\ 'S': 'S'
				\ }
				]])
		end,
	},
	{
		"tigh-latte/coke.nvim",
		-- dir = "~/Dev/git.tigh.dev/tigh-latte/coke.nvim",
		lazy = statusline ~= nil and statusline ~= "coke",
		depedencies = { "tpope/vim-fugitive" },
		config = function()
			require("coke").setup({
				modes = {
					n = { txt = "N", hl = { bg = "#d7af87" } },
					niI = { txt = "NI", hl = { bg = "#d7af87" } },
					no = { txt = "no", hl = { bg = "#d7af87" } },
					i = { txt = "I", hl = { bg = "#73b8f1" } },
					ix = { txt = "I-O", hl = { bg = "#73b8f1" } },
					R = { txt = "R", hl = { bg = "#af5f5a" } },
					Rv = { txt = "Rv", hl = { bg = "#af5f5a" } },
					ic = { txt = "IC", hl = { bg = "#53892c" } },
					c = { txt = "C", hl = { bg = "#53892c" } },
					v = { txt = "V", hl = { bg = "#d19a66" } },
					V = { txt = "V-LINE", hl = { bg = "#d19a66" } },
					[""] = { txt = "V-BLOCK", hl = { bg = "#d19a66" } },
					s = { txt = "S", hl = { bg = "#d19a66" } },
					S = { txt = "S", hl = { bg = "#d19a66" } },
					nt = { txt = "t", hl = { bg = "#53892c" } },
					t = { txt = "t", hl = { bg = "#53892c" } },
				},
			})
		end,
	},
}
