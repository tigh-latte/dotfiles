local lspconfig = require("lspconfig")
local util = require("lspconfig/util")

vim.opt.completeopt = { "menuone", "noselect", "noinsert", "preview" }

local on_attach = function(_, bufnr)
	require("lsp_signature").on_attach({
		bind = true,
		doc_lines = 0,
		handler_opts = {
			border = "none",
		},
		hint_enable = false,
	}, bufnr)

	local opts = { buffer = bufnr, remap = false }

	vim.keymap.set("n", "<Leader>cdd", vim.lsp.buf.definition, opts)

	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "<Leader>cref", vim.lsp.buf.references, opts)
	vim.keymap.set("n", "<Leader>cren", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "<Leader>cp", vim.diagnostic.goto_prev, opts)
	vim.keymap.set("n", "<Leader>cn", vim.diagnostic.goto_next, opts)
	vim.keymap.set("n", "<Leader>cee", vim.diagnostic.open_float, opts)
	vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)

	vim.keymap.set("n", "<Leader>csq", vim.lsp.buf.workspace_symbol, opts)
end

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

		["<C-S-f>"] = cmp.mapping.scroll_docs(-4),

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
		fields = { "abbr", "kind", "menu" },
		format = function(entry, item)
			local s = ""
			if entry.completion_item.detail ~= nil and entry.completion_item.detail ~= "" then
				s = " " .. entry.completion_item.detail
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

local capabilities = vim.lsp.protocol.make_client_capabilities()
lspconfig.gopls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	root_dir = util.root_pattern("go.work", "go.mod", ".git"),
	single_file_support = true,
	settings = {
		gopls = {
			buildFlags = { "-tags=integration" },
			completeUnimported = true,
			usePlaceholders = true,
			gofumpt = true,
			staticcheck = true,
			symbolScope = "workspace",
			analyses = {
				unusedparams = true,
				fieldalignment = true,
				shadow = true,
			},
		},
	},
})
lspconfig.jedi_language_server.setup({
	on_attach = on_attach,
	filetypes = { "python" },
	root_dir = util.root_pattern(".git"),
	single_file_support = true,
})

lspconfig.tsserver.setup({
	on_attach = on_attach,
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
	},
	root_dir = util.root_pattern(".git"),
	single_file_support = true,
})

lspconfig.bashls.setup({
	on_attach = on_attach,
	filetypes = { "sh", "bash" },
	root_dir = util.root_pattern(".git"),
	single_file_support = true,
})

lspconfig.lua_ls.setup({
	on_attach = on_attach,
	filetypes = { "lua" },
	root_dir = util.root_pattern(".git"),
	single_file_support = true,
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
				path = vim.split(package.path, ";"),
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
				},
			},
		},
	},
})

local signs = { Error = "😱", Warn = "🤔", Hint = "", Info = "" }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.api.nvim_set_hl(0, "DiagnosticWarn", { ctermfg = 172 })

vim.diagnostic.config({
	virtual_text = {
		prefix = "•",
	},
})
