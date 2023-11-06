require("mason").setup()
require("mason-lspconfig").setup {
	ensure_installed = {
		"gopls",
		"jedi_language_server",
	}
}
