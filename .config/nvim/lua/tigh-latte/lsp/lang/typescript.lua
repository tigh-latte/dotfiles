require("lspconfig").tsserver.setup({
	on_attach = require("tigh-latte.lsp").make_on_attach({
		on_save_actions = {
			"source.sortImports.ts",
			"source.addMissingImports.ts",
			"source.removeUnusedImports.ts",
		},
	}),
	capabilities = vim.lsp.protocol.make_client_capabilities(),
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
	},
	root_dir = require("lspconfig/util").root_pattern(".git"),
	single_file_support = true,
	settings = {
		typescript = {
			format = {
				indentSize = 2,
				tabSize = 2,
				convertTabsToSpaces = true,
				semicolons = "remove",
			},
		},
	},
})
