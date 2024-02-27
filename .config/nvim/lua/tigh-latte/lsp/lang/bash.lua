local on_attach = require("tigh-latte.lsp.on_attach").on_attach
local util = require("lspconfig/util")

require("lspconfig").bashls.setup({
	on_attach = on_attach,
	capabilities = vim.lsp.protocol.make_client_capabilities(),
	filetypes = { "sh", "bash" },
	root_dir = util.root_pattern(".git"),
	single_file_support = true,
})
