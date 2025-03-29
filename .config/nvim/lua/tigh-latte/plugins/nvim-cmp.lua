return {
	{
		"hrsh7th/nvim-cmp",
		event = "VeryLazy",
		dependencies = {
			{ "neovim/nvim-lspconfig" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },
			{ "hrsh7th/cmp-nvim-lsp-signature-help" },
			{ "hrsh7th/cmp-vsnip" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/vim-vsnip" },
			{ "hrsh7th/cmp-calc" },
		},
		config = function()
			local cmp = require("cmp")
			local mapping = cmp.mapping
			cmp.setup({
				mapping = {
					-- Completion window config strats
					["<C-p>"] = mapping.select_prev_item(),
					["<C-n>"] = mapping.select_next_item(),
					["<Down>"] = mapping.select_next_item(),
					["<Up>"] = mapping.select_prev_item(),
					["<S-Tab>"] = mapping.select_prev_item(),
					["<Tab>"] = mapping(function(fallback)
						if not cmp.visible() then
							fallback()
							return
						end
						if #cmp.get_entries() ~= 1 then
							cmp.select_next_item()
							return
						end
						-- If only one suggestion is available, tab will confirm it rather than
						-- select it.
						cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
					end),
					["<C-Space>"] = mapping(function()
						if cmp.visible() then
							cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
						else
							cmp.complete()
						end
					end),
					["<C-d>"] = mapping.scroll_docs(6),
					["<C-u>"] = mapping.scroll_docs(-6),
					-- Confirm strats
					["<CR>"] = mapping.confirm({
						behavior = cmp.ConfirmBehavior.Insert,
						select = false,
					}),
				},

				sources = {
					{ name = "calc" },
					{ name = "path" },
					{ name = "nvim_lua", keyword_length = 2 },
					{ name = "nvim_lsp", keyword_length = 1 },
					{ name = "buffer",   keyword_length = 1 },
					{ name = "vsnip",    keyword_length = 2 },
					{ name = "lazydev",  group_index = 0,   keyword_length = 1 },
				},

				experimental = {
					ghost_text = true,
				},

				preselect = cmp.PreselectMode.None,

				snippet = {
					expand = function(args)
						vim.fn["vsnip#anonymous"](args.body)
					end,
				},

				formatting = {
					expandable_indicator = false,
					fields = { "abbr", "kind", "menu" },
					format = function(entry, item)
						local s = ""
						-- Make go import paths for third party libs shorter.
						if vim.bo.ft == "go" and entry.completion_item.detail ~= nil and entry.completion_item.detail ~= "" then
							-- TODO: Make this work for everything, not just github.
							s = entry.completion_item.detail:gsub("github.com/", "gh://")
						end
						return vim.tbl_extend("force", item, {
							menu = ({
								nvim_lsp = "λ " .. s,
								nvim_lua = "vi " .. s,
								vsnip = "> " .. s,
								buffer = "b " .. s,
								path = "p " .. s,
							})[entry.source.name],
						})
					end,
				},
			})
		end,

	},
	{
		"ray-x/lsp_signature.nvim",
		event = "VeryLazy",
		config = function()
			require("lsp_signature").setup({
				bind = false,
				doc_lines = 0,
				handler_opts = {
					border = "none",
				},
				hint_enable = "false",
			})
		end,
	},
}
