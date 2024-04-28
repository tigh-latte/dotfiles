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
				toml = {
					require("formatter.filetypes.toml").taplo,
				},
				["*"] = {
					require("formatter.filetypes.any").remove_trailing_whitespace,
				},
			},
		})

		-- Format on save, on all buffers.
		-- Will only actually run on buffers with filestypes specified above.
		vim.cmd([[
			augroup FormatAutogroup
			  autocmd!
			  autocmd BufWritePost * FormatWrite
			augroup END
		]])
	end,
}
