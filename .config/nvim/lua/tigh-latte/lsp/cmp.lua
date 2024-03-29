local cmp = require("cmp")

cmp.setup({
	mapping = {
		-- Completion window config strats
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<Down>"] = cmp.mapping.select_next_item(),
		["<Up>"] = cmp.mapping.select_prev_item(),
		["<S-Tab>"] = cmp.mapping.select_prev_item(),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				-- if one entry is available, insert it.
				if #cmp.get_entries() == 1 then
					cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })
				else
					cmp.select_next_item()
				end
			else
				fallback()
			end
		end),

		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),

		["<C-f>"] = cmp.mapping.scroll_docs(4),

		-- Confirm strats
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Insert,
			select = false,
		}),
		["<Right>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		}),
	},

	sources = {
		{ name = "path" },
		{ name = "nvim_lsp", keyword_length = 1 },
		{ name = "nvim_lua", keyword_length = 2 },
		{ name = "buffer", keyword_length = 1 },
		{ name = "vsnip", keyword_length = 2 },
		{ name = "calc" },
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
			if entry.completion_item.detail ~= nil and entry.completion_item.detail ~= "" then
				s = " " .. entry.completion_item.detail:gsub("github.com/", "gh://")
			end
			item.menu = ({
				nvim_lsp = "λ" .. s,
				vnip = ">" .. s,
				buffer = "b" .. s,
				path = "p" .. s,
			})[entry.source.name]

			return item
		end,
	},
})
