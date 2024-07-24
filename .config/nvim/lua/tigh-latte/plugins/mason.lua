local function i(lang)
	return require("tigh-latte.lsp.lang." .. lang)
end

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
			local capabilities = vim.tbl_extend("force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				require("cmp_nvim_lsp").default_capabilities({
					snippetSupport = false,
				})
			)

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
				handlers = {
					function(ls)
						require("lspconfig")[ls].setup {
							on_attach = require("tigh-latte.lsp").make_on_attach(),
							capabilities = capabilities,
						}
					end,
					gopls = i("go"),
					tsserver = i("typescript"),
					pyright = i("python"),
					lua_ls = i("lua"),
					taplo = i("toml"),
					cucumber_language_server = i("cucumber"),
				},
			})
		end,
	},
}
