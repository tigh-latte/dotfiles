return {
	{
		"williamboman/mason.nvim",
		config = true,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					"jq",
					"golangci-lint",
					"prettier",
					"prettierd",
					"stylua",
					"taplo",
					"tree-sitter-cli",
				},
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"gopls",
					"pyright",
					"tsserver",
					"bashls",
					"lua_ls",
					"htmx",
					"html",
					"yamlls",
					"cucumber_language_server",
				},
			})
		end,
	},
}
