vim.lsp.config('cfn_lsp', {
	cmd = { "node", "/home/tigh/Dev/cfnlsp/cfn-lsp-server-standalone.js", "--stdio" },
	filetypes = { "yaml.cf" },
	init_options = {
		aws = {
			clientInfo = {
				extension = { name = "neovim", version = vim.version().major .. "." .. vim.version().minor },
				clientId = vim.fn.hostname(),
			},
			telemetryEnabled = false,
		},
	},
})
vim.lsp.enable('cfn_lsp', true)
