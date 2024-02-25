vim.g.copilot_assume_mapped = true
vim.g.copilot_no_tab_map = true
vim.keymap.set("i", "<C-i>", 'colpilot#Accept("<CR>)', {
	expr = true,
	replace_keycodes = false,
})
