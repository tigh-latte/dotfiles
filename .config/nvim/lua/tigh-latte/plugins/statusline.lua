local statusline = os.getenv("NVIM_STATUSLINE") or "coke"

if statusline == "lualine" then
	vim.pack.add {
		gh "nvim-lualine/lualine.nvim",
	}
	require("lualine").setup {
		options = {
			refresh = {
				statusline = 100,
			}
		}
	}
elseif statusline == "airline" then
	vim.pack.add {
		gh "vim-airline/vim-airline",
	}
	vim.cmd([[
		let g:airline#extensions#undotree#enabled = 1
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
elseif statusline == "coke" then
	vim.pack.add {
		gh "tigh-latte/coke.nvim",
	}
	require("coke").setup({
		modes = {
			n = { txt = "N", hl = { bg = "#d7af87" } },
			niI = { txt = "NI", hl = { bg = "#d7af87" } },
			no = { txt = "no", hl = { bg = "#d7af87" } },
			i = { txt = "I", hl = { bg = "#73b8f1" } },
			ix = { txt = "I-O", hl = { bg = "#73b8f1" } },
			["r?"] = { txt = "r", hl = { bg = "#af5f5a" } },
			R = { txt = "R", hl = { bg = "#af5f5a" } },
			Rv = { txt = "Rv", hl = { bg = "#af5f5a" } },
			ic = { txt = "IC", hl = { bg = "#53892c" } },
			c = { txt = "C", hl = { bg = "#53892c" } },
			v = { txt = "V", hl = { bg = "#d19a66" } },
			V = { txt = "V-LINE", hl = { bg = "#d19a66" } },
			[""] = { txt = "V-BLOCK", hl = { bg = "#d19a66" } },
			s = { txt = "S", hl = { bg = "#d19a66" } },
			S = { txt = "S", hl = { bg = "#d19a66" } },
			nt = { txt = "t", hl = { bg = "#d7af87" } },
			t = { txt = "t", hl = { bg = "#73b8f1" } },
		},
	})
end
