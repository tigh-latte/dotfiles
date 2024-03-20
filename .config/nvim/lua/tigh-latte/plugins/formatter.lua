return {
	"mhartington/formatter.nvim",
	config = function()
		require("formatter").setup({
			logging = true,
			log_level = vim.log.levels.WARN,
			filetype = {
				typescript = {
					require("formatter.filetypes.typescript").prettier,
				},
				typescriptreact = {
					require("formatter.filetypes.typescriptreact").prettierd,
				},
				javascript = {
					require("formatter.filetypes.javascript").prettier,
				},
				javascriptreact = {
					require("formatter.filetypes.javascriptreact").prettierd,
				},
				json = {
					require("formatter.filetypes.json").jq,
				},
				toml = {
					require("formatter.filetypes.toml").taplo,
				},
				["*"] = {
					require("formatter.filetypes.any").remove_trailing_whitespace,
				},
			},
		})

		vim.cmd([[
			augroup FormatAutogroup
			  autocmd!
			  autocmd BufWritePost * FormatWrite
			augroup END
		]])
	end,
}
