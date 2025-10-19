vim.lsp.config("yamlls", {
	settings = {
		yaml = {
			format = {
				enable = true,
			},
		},
		redhat = {
			telemetry = {
				enabled = false,
			},
		},
	},
})
