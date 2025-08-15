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
			local lsps = require("lspconfig")
			local capabilities = vim.tbl_extend("force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				require("cmp_nvim_lsp").default_capabilities()
			)

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

				handlers = {
					function(ls)
						lsps[ls].setup({
							on_attach = require("tigh-latte.lsp").make_on_attach(),
							capabilities = capabilities,
						})
					end,

					gopls = function()
						lsps.gopls.setup({
							on_attach = require("tigh-latte.lsp").make_on_attach({
								on_save_actions = { "source.organizeImports" },
							}),
							capabilities = capabilities,
							filetypes = { "go", "gomod", "gowork", "gotmpl" },
							root_dir = require("lspconfig/util").root_pattern("go.work", "go.mod", ".git"),
							single_file_support = true,
							settings = {
								gopls = {
									buildFlags = { "-tags=integration" },
									completeUnimported = true,
									usePlaceholders = false,
									vulncheck = "imports",
									gofumpt = true,
									staticcheck = true,
									symbolScope = "workspace",
									analyses = {
										unusedparams = true,
										nilness = true,
										unusedwrite = true,
										stdversion = true,
										shadow = true,
									},
									hints = {
										assignVariableTypes = true,
										compositeLiteralFields = true,
										compositeLiteralTypes = false,
										constantValues = true,
										functionTypeParameters = true,
										parameterNames = true,
										rangeVariableTypes = true,
									},
								},
							},
						})
					end,

					ts_ls = function()
						lsps.ts_ls.setup({
							on_attach = require("tigh-latte.lsp").make_on_attach({
								on_save_actions = {
									"source.sortImports.ts",
									"source.addMissingImports.ts",
									"source.removeUnusedImports.ts",
								},
							}),
							capabilities = capabilities,
							filetypes = {
								"javascript", "javascriptreact", "javascript.jsx",
								"typescript", "typescriptreact", "typescript.tsx",
							},
							root_dir = require("lspconfig/util").root_pattern(".git"),
							single_file_support = true,
							settings = {
								typescript = {
									format = {
										indentSize = 2,
										tabSize = 2,
										convertTabsToSpaces = true,
										semicolons = "remove",
									},
								},
								javascript = {
									format = {
										indentSize = 2,
										tabSize = 2,
										convertTabsToSpaces = true,
										semicolons = "remove",
									},
								},
							},
						})
					end,

					pyright = function()
						lsps.pyright.setup({
							on_attach = require("tigh-latte.lsp").make_on_attach(),
							capabilities = capabilities,
							filetypes = { "python" },
							root_dir = require("lspconfig/util").root_pattern(".git"),
							single_file_support = true,
							settings = {
								python = {
									useLibraryCodeForTypes = true,
									analysis = {
										autoSearchPaths = true,
										autoImportCompletions = true,
										diagnosticMode = "workspace",
										useLibraryCodeForTypes = true,
										extraPaths = { "." },
									},
								},
							},
						})
					end,

					lua_ls = function()
						lsps.lua_ls.setup({
							on_attach = require("tigh-latte.lsp").make_on_attach(),
							capabilities = capabilities,
							filetypes = { "lua" },
							root_dir = require("lspconfig/util").root_pattern(".git"),
							single_file_support = true,
							settings = {
								Lua = {
									workspace = {
										library = vim.api.nvim_get_runtime_file("", true),
									},
									format = {
										enable = true,
										defaultConfig = {
											table_seperator_style = "comma",
											trailing_table_separator = "smart",
											call_arg_parentheses = "keep",
											quote_style = "double",
										},
									},
								},
							},
						})
					end,

					taplo = function()
						lsps.taplo.setup({
							on_attach = require("tigh-latte.lsp").make_on_attach(),
							capabilities = capabilities,
							settings = {
								evenBetterToml = {
									formatter = {
										alignEntries = true,
										indentEntries = true,
										indentTables = true,
										indentString = "  ",
									},
								},
							},
						})
					end,

					cucumber_language_server = function()
						lsps.cucumber_language_server.setup({
							on_attach = require("tigh-latte.lsp").make_on_attach(),
							capabilities = capabilities,
							settings = {
								cucumber = {
									features = { "**/*.feature" },
									glue = { "**/steps*.go" },
								},
							},
						})
					end,

				},
			})
		end,
	},
}
