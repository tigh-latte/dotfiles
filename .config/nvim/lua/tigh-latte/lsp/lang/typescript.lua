require("lspconfig").tsserver.setup({
	on_attach = require("tigh-latte.lsp").make_on_attach({
		on_save_actions = {
			"source.sortImports.ts",
			"source.addMissingImports.ts",
			"source.removeUnusedImports.ts",
		},
	}),
	capabilities = vim.tbl_extend("force", {},
		vim.lsp.protocol.make_client_capabilities(),
		require("cmp_nvim_lsp").default_capabilities({ snippetSupport = false })
	),
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
		javascript = {
			format = {
				indentSize = 2,
				tabSize = 2,
				convertTabsToSpaces = true,
				semicolons = "remove",
			},
		},
	},
})
