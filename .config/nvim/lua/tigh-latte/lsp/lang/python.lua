local on_attach = require("tigh-latte.lsp.on_attach").on_attach
local util = require("lspconfig/util")

require("lspconfig").jedi_language_server.setup({
	on_attach = on_attach,
	capabilities = vim.lsp.protocol.make_client_capabilities(),
	filetypes = { "python" },
	root_dir = util.root_pattern(".git"),
	single_file_support = true,
})
