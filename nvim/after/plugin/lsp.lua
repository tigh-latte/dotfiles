lspconfig = require("lspconfig")
util = require("lspconfig/util")

vim.opt.completeopt = { 'menuone', 'noselect', 'noinsert', 'preview' }

local on_attach = function(client, bufnr)
	local opts = {buffer = bufnr, remap = false}

	vim.keymap.set("n", "gdd", function() vim.lsp.buf.definition() end, opts)
	vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
	vim.keymap.set("n", "<leader>gref", function() vim.lsp.buf.references() end, opts)
	vim.keymap.set("n", "<leader>ren", function() vim.lsp.buf.rename() end, opts)
	vim.keymap.set("n", "<leader>pp", function() vim.diagnostic.goto_prev() end, opts)
	vim.keymap.set("n", "<leader>nn", function() vim.diagnostic.goto_next() end, opts)
	vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end

local cmp = require('cmp')

cmp.setup({
	mapping = {
		-- Completion window config strats
		['<C-p>'] = cmp.mapping.select_prev_item(),
		['<C-n>'] = cmp.mapping.select_next_item(),
		['<Down>'] = cmp.mapping.select_next_item(),
		['<Up>'] = cmp.mapping.select_prev_item(),
		['<S-Tab>'] = cmp.mapping.select_prev_item(),
		['<Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				-- if one entry is available, insert it.
				if #cmp.get_entries() > 1 then
					cmp.select_next_item()
				else
					cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })
				end
			else
				fallback()
			end
		end),

		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.close(),


		['<C-S-f>'] = cmp.mapping.scroll_docs(-4),
		['<C-S-f>'] = cmp.mapping.scroll_docs(-4),

		-- Confirm strats
		['<CR>'] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		}),
		['<Right>'] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		}),
	},

	sources = {
		{ name = 'path' },
		{ name = 'nvim_lsp', keyword_length = 1 },
		{ name = 'nvim_lsp_signature_help' },
		{ name = 'nvim_lua', keyword_length = 2 },
		{ name = 'buffer', keyword_length = 1 },
		{ name = 'vsnip', keyword_length = 2 },
	},

	preselect = cmp.PreselectMode.None,

	snippet = {
		expand = function(args)
			vim.fn['vsnip#anonymous'](arg.body)
		end,
	},

	formatting = {
		fields = {'menu', 'abbr', 'kind'},
		format = function(entry, item)
			local menu_icon = {
				nvim_lsp = 'λ',
				vnip = '>',
				buffer = 'b',
				path = 'p',
			}
			item.menu = menu_icon[entry.source.name]
			return item
		end,
	},
})


local capabilities = vim.lsp.protocol.make_client_capabilities()
lspconfig.gopls.setup {
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = { "gopls" },
	filetypes = {"go", "gomod", "gowork", "gotmpl"},
	root_dir = util.root_pattern("go.work", "go.mod", ".git"),
	single_file_support = true,
	settings = {
		gopls = {
			completeUnimported = true,
			usePlaceholders = true,
			gofumpt = true,
			staticcheck = true,
			analyses = { unusedparams = true },
		},
	},
}

local signs = { Error = "😱", Warn = "🤔", Hint = "", Info = "" }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.api.nvim_set_hl(0, 'DiagnosticWarn', { ctermfg=172})

vim.diagnostic.config({
	virtual_text = {
		prefix = '•'
	}
})
