local util = require("lspconfig/util")

require("lspconfig").tsserver.setup({
	on_attach = require("tigh-latte.lsp").make_on_attach(),
	capabilities = vim.lsp.protocol.make_client_capabilities(),
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
	},
	root_dir = util.root_pattern(".git"),
	single_file_support = true,
})
