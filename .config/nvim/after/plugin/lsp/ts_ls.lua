vim.lsp.config("ts_ls", {
	filetypes = {
		"javascript", "javascriptreact", "javascript.jsx",
		"typescript", "typescriptreact", "typescript.tsx",
	},
	root_dir = function(bufnr, on_dir)
		local root = vim.fs.root(bufnr, { ".git" })
		on_dir(root or vim.fn.getcwd())
	end,
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
