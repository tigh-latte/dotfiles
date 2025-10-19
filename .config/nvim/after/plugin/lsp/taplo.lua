vim.lsp.config("taplo", {
	settings = {
		evenBetterToml = {
			formatter = {
				alignEntries = true,
				indentEntries = true,
				indentTables = true,
				indentString = "  ",
			},
		},
	},
})
