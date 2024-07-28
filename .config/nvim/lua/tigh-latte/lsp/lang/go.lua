require("lspconfig").gopls.setup({
	on_attach = require("tigh-latte.lsp").make_on_attach({
		on_save_actions = { "source.organizeImports" },
	}),
	capabilities = vim.tbl_extend("force",
		{},
		vim.lsp.protocol.make_client_capabilities(),
		require("cmp_nvim_lsp").default_capabilities({ snippetSupport = false })
	),
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	root_dir = require("lspconfig/util").root_pattern("go.work", "go.mod", ".git"),
	single_file_support = true,
	settings = {
		gopls = {
			buildFlags = { "-tags=integration" },
			completeUnimported = true,
			usePlaceholders = false,
			vulncheck = "imports",
			gofumpt = true,
			staticcheck = true,
			symbolScope = "workspace",
			analyses = {
				unusedparams = true,
				nilness = true,
				unusedwrite = true,
				stdversion = true,
				shadow = true,
			},
			hints = {
				assignVariableTypes = true,
				compositeLiteralFields = true,
				compositeLiteralTypes = false,
				constantValues = true,
				functionTypeParameters = true,
				parameterNames = true,
				rangeVariableTypes = true,
			},
		},
	},
})
