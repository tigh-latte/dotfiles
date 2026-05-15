vim.lsp.config('cfn_lsp', {
	cmd = {
		"node",
		"/home/tigh/Dev/github.com/aws-cloudformation/cloudformation-languageserver/bundle/production/cfn-lsp-server-standalone.js",
		"--stdio" },
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

local cfyaml = function(_, bufnr)
	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)
	return (0 < #lines and lines[1]:match("^AWSTemplateFormatVersion:") and "yaml.cf" or "yaml")
end

vim.filetype.add({
	extension = {
		yml = cfyaml,
		yaml = cfyaml,
	},
})


vim.lsp.enable('cfn_lsp', true)
