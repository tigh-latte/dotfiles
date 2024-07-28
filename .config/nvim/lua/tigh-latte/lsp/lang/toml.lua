require("lspconfig").taplo.setup({
	on_attach = require("tigh-latte.lsp").make_on_attach(),
	capabilities = vim.tbl_extend("force", {},
		vim.lsp.protocol.make_client_capabilities(),
		require("cmp_nvim_lsp").default_capabilities({ snippetSupport = false })
	),
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
