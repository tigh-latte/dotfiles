local util = require "formatter.util"

require('formatter').setup {
	logging = true,
	log_leel = vim.log.levels.INFO,
	filetype = {
		go = {
			require("formatter.filetypes.go").gofumpt,
			require("formatter.filetypes.go").goimports,
		},
		["*"] = {
			require("formatter.filetypes.any").remove_trailing_whitespace
		}
	},
}

vim.cmd([[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost * FormatWrite
augroup END
]])
