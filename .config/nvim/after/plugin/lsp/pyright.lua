vim.lsp.config("pyright", {
	filetypes = { "python" },
	root_dir = function(bufnr, on_dir)
		local root = vim.fs.root(bufnr, { ".git" })
		on_dir(root or vim.fn.getcwd())
	end,
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
