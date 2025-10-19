vim.lsp.config("gopls", {
	root_dir = function(bufnr, on_dir)
		local root = vim.fs.root(bufnr, { "go.work", "go.mod", ".git" })
		on_dir(root and root or vim.fn.getcwd())
	end,
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
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
