vim.api.nvim_create_autocmd({ "BufEnter", "BufNewFile" }, {
	pattern = "*.sway",
	command = "set filetype=swayconfig",
})
