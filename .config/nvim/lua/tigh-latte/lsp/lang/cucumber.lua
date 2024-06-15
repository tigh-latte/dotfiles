local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
require("lspconfig").cucumber_language_server.setup({
	on_attach = require("tigh-latte.lsp").make_on_attach(),
	capabilities = capabilities,
	settings = {
		cucumber = {
			features = { "**/*.feature" },
			glue = { "**/*_test.go" },
		},
	},
})
