local util = require("lspconfig/util")

require("lspconfig").lua_ls.setup({
	on_attach = require("tigh-latte.lsp").on_attach,
	capabilities = vim.lsp.protocol.make_client_capabilities(),
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
