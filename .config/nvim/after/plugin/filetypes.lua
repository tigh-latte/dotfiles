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
