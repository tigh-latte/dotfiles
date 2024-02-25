require("mason").setup()
require("mason-tool-installer").setup({
	ensure_installed = {
		"jq",
		"golangci-lint",
		"prettier",
		"prettierd",
		"stylua",
		"taplo",
	},
})
require("mason-lspconfig").setup({
	ensure_installed = {
		"gopls",
		"jedi_language_server",
		"tsserver",
		"bashls",
		"lua_ls",
		"jqls",
	},
})
