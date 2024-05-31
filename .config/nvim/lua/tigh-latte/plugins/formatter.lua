return {
	"mhartington/formatter.nvim",
	config = function()
		require("formatter").setup({
			logging = true,
			log_level = vim.log.levels.WARN,
			filetype = {
				javascript = {
					require("formatter.filetypes.javascript").prettier,
				},
				javascriptreact = {
					require("formatter.filetypes.javascriptreact").prettierd,
				},
				toml = {
					require("formatter.filetypes.toml").taplo,
				},
			},
		})

		-- Format on save, on all buffers.
		-- Will only actually run on buffers with filestypes specified above.
		local augroup = vim.api.nvim_create_augroup("FormatAutogroup", { clear = true })
		vim.api.nvim_create_autocmd("BufWritePost", {
			group = augroup,
			pattern = "*",
			callback = function() vim.cmd.FormatWrite() end,
		})
	end,
}
