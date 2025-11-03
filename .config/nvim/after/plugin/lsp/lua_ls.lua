vim.lsp.config("lua_ls", {
	capabilities = vim.lsp.protocol.make_client_capabilities(),
	filetypes = { "lua" },
	single_file_support = true,
	settings = {
		Lua = {
			checkThirdParty = true,
			workspace = {
				library = { vim.env.VIMRUNTIME },
			},
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
})

vim.lsp.enable("stylua", false)
