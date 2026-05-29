vim.lsp.enable("stylua", false)
return {
	capabilities = vim.lsp.protocol.make_client_capabilities(),
	filetypes = { "lua" },
	single_file_support = true,
	settings = {
		Lua = {
			telemetry = { enable = false },
			format = {
				enable = true,
				defaultConfig = {
					table_seperator_style = "comma",
					trailing_table_separator = "smart",
					call_arg_parentheses = "keep",
					quote_style = "double",
				},
			},
		},
	},
}
