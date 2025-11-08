vim.lsp.config("cucumber_language_server", {
	settings = {
		cucumber = {
			features = { "**/*.feature" },
			glue = { "**/steps*.go" },
		},
	},
})
