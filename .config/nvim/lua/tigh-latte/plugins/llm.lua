return {
	"jackMort/ChatGPT.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim",
		"folke/trouble.nvim",
		"nvim-telescope/telescope.nvim",
	},

	config = function()
		require("chatgpt").setup({
			yank_register = '"',
			popup_layout = {
				default = "right",
			},
			openai_params = {
				model = "gpt-4-1106-preview",
			},
			openai_edit_params = {
				model = "gpt-4-1106-preview",
			},
		})
		vim.keymap.set("n", "<Leader>llm", ":ChatGPT<CR>")
	end,
}
