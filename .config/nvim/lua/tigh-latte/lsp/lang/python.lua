require("lspconfig").pyright.setup({
	on_attach = require("tigh-latte.lsp").make_on_attach(),
	capabilities = vim.tbl_extend("force", {},
		vim.lsp.protocol.make_client_capabilities(),
		require("cmp_nvim_lsp").default_capabilities()
	),
	filetypes = { "python" },
	root_dir = require("lspconfig/util").root_pattern(".git"),
	single_file_support = true,
	settings = {
		python = {
			useLibraryCodeForTypes = true,
			analysis = {
				autoSearchPaths = true,
				autoImportCompletions = true,
				diagnosticMode = "workspace",
				useLibraryCodeForTypes = true,
				extraPaths = { "." },
			},
		},
	},
})
