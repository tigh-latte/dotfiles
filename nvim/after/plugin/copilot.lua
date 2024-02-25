vim.g.copilot_assume_mapped = true
vim.g.copilot_no_tab_map = true
vim.keymap.set("i", "<C-i>", 'colpilot#Accept("<CR>)', {
	expr = true,
	replace_keycodes = false,
})

require("chatgpt").setup({
	api_key_cmd = "echo $CHATGPT_API_KEY",
	yank_register = '"',
	openai_params = {
		model = "gpt-4-1106-preview",
	},
	openai_edit_params = {
		model = "gpt-4-1106-preview",
	},
})
