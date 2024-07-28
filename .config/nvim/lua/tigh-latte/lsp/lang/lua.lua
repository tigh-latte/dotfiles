require("lspconfig").lua_ls.setup({
	on_attach = require("tigh-latte.lsp").make_on_attach(),
	capabilities = vim.tbl_extend("force", {},
		vim.lsp.protocol.make_client_capabilities(),
		require("cmp_nvim_lsp").default_capabilities()
	),
	filetypes = { "lua" },
	root_dir = require("lspconfig/util").root_pattern(".git"),
	single_file_support = true,
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
				path = vim.split(package.path, ";"),
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
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				checkThirdParty = false,
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
				},
			},
		},
	},
})
