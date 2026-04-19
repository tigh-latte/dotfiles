vim.lsp.config("openscad_lsp", {
	capabilities = vim.lsp.protocol.make_client_capabilities(),
	filetypes = { "openscad" },
	single_file_support = true,
	root_dir = function(bufnr, on_dir)
		local root = vim.fs.root(bufnr, { ".git" })
		on_dir(root and root or vim.fn.getcwd())
	end,
})

vim.lsp.enable("openscad_lsp")
