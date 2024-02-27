local on_attach = require("tigh-latte.lsp.on_attach").on_attach
local util = require("lspconfig/util")

require("lspconfig").gopls.setup({
	on_attach = on_attach,
	capabilities = vim.lsp.protocol.make_client_capabilities(),
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	root_dir = util.root_pattern("go.work", "go.mod", ".git"),
	single_file_support = true,
	settings = {
		gopls = {
			buildFlags = { "-tags=integration" },
			completeUnimported = true,
			usePlaceholders = true,
			vulncheck = "imports",
			gofumpt = true,
			staticcheck = true,
			symbolScope = "workspace",
			analyses = {
				unusedparams = true,
				fieldalignment = true,
				shadow = true,
			},
		},
	},
})
