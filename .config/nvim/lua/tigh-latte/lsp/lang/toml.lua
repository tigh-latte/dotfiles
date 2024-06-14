require("lspconfig").taplo.setup({
	on_attach = require("tigh-latte.lsp").make_on_attach(),
	capabilities = vim.lsp.protocol.make_client_capabilities(),
	settings = {
		evenBetterToml = {
			formatter = {
				alignEntries = true,
				indentEntries = true,
				indentTables = true,
				indentString = "  ",
			},
		},
	},
})
