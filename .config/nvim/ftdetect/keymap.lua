vim.api.nvim_create_autocmd({"BufEnter", "BufNewFile"}, {
	pattern = "*.keymap",
	command = "set filetype=c",
})
