vim.lsp.config("lua_ls", {
	filetypes = { "lua" },
	single_file_support = true,
	settings = {
		Lua = {
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
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
