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
					"jedi_language_server",
					"tsserver",
					"bashls",
					"lua_ls",
					"jqls",
				},
			})
		end,
	},
}