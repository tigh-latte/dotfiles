local util = require("lspconfig/util")

require("lspconfig").pyright.setup({
	on_attach = require("tigh-latte.lsp").on_attach,
	capabilities = vim.lsp.protocol.make_client_capabilities(),
	filetypes = { "python" },
	root_dir = util.root_pattern(".git"),
	single_file_support = true,
	settings = {
		pyright = {
			useLibraryCodeForTypes = true,
			venvPath = ".venv",
			analysis = {
				autoSearchPaths = true,
				autoImportCompletions = true,
				diagnosticMode = "workspace",
				useLibraryCodeForTypes = true,
			},
		},
	},
})
