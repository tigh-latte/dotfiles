vim.lsp.config("gh_actions_ls", {
	filetypes = { "yaml.gha" },
})

vim.filetype.add({
	pattern = {
		[".github/workflows/.*%.yaml"] = 'yaml.gha',
		[".github/workflows/.*%.yml"] = 'yaml.gha',
	}
})

vim.lsp.enable("gh_actions_ls", true)
