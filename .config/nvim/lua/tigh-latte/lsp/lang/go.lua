require("lspconfig").gopls.setup({
	on_attach = require("tigh-latte.lsp").make_on_attach({
		on_save_actions = { "source.organizeImports" },
	}),
	capabilities = vim.lsp.protocol.make_client_capabilities(),
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	root_dir = require("lspconfig/util").root_pattern("go.work", "go.mod", ".git"),
	single_file_support = true,
	settings = {
		gopls = {
			buildFlags = { "-tags=integration" },
			completeUnimported = true,
			usePlaceholders = true,
			vulncheck = "imports",
			gofumpt = true,
			staticcheck = true,
			symbolScope = "workspace",
			analyses = {
				unusedparams = true,
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
