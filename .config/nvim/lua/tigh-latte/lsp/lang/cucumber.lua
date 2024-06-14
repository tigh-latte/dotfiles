require("lspconfig").cucumber_language_server.setup({
	cmd = { "/usr/bin/cucumber-language-server", "--stdio" },
	on_attach = require("tigh-latte.lsp").make_on_attach(),
	capabilities = vim.lsp.protocol.make_client_capabilities(),
	settings = {
		cucumber = {
			feature = { "testing/integration/features/*.feature" },
			glue = { "**/*_test.go" },
		},
	},
})
