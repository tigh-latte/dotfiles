return function()
	require("lspconfig").cucumber_language_server.setup({
		on_attach = require("tigh-latte.lsp").make_on_attach(),
		capabilities = vim.tbl_extend("force", {},
			vim.lsp.protocol.make_client_capabilities(),
			require("cmp_nvim_lsp").default_capabilities()
		),
		settings = {
			cucumber = {
				features = {
					"**/*.feature",
				},
				glue = {
					"**/steps.go",
				},
			},
		},
	})
end
