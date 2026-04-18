vim.pack.add {
	gh "williamboman/mason.nvim",
	gh "WhoIsSethDaniel/mason-tool-installer.nvim",
	gh "williamboman/mason-lspconfig.nvim",
}

require("mason").setup()
require("mason-tool-installer").setup {
	ensure_installed = {
		"jq",
		"golangci-lint",
		"prettier",
		"prettierd",
		"stylua",
		"taplo",
		"tree-sitter-cli",
	},
}

require("mason-lspconfig").setup {
	automatic_installation = false,
	ensure_installed = {
		"gopls",
		"pyright",
		"ts_ls",
		"bashls",
		"lua_ls",
		"htmx",
		"html",
		"yamlls",
		"jsonls",
		"rust_analyzer",
		"openscad_lsp",
		"cucumber_language_server",
	},
}
