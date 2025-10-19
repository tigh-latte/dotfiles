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
					"rust_analyzer",
					"cucumber_language_server",
				},
			})
		end,
	},
}
