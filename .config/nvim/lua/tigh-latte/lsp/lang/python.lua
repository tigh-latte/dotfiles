require("lspconfig").pyright.setup({
	on_attach = require("tigh-latte.lsp").make_on_attach(),
	capabilities = vim.lsp.protocol.make_client_capabilities(),
	filetypes = { "python" },
	root_dir = require("lspconfig/util").root_pattern(".git"),
	single_file_support = true,
	settings = {
		python = {
			useLibraryCodeForTypes = true,
			venvPath = ".",
			pythonPath = "./.venv/bin/python",
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
