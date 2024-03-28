return {
	"Robitx/gp.nvim",
	config = function()
		require("gp").setup({})
		vim.keymap.set("n", "<Leader>llm", ":GpChatToggle vsplit<CR>G")
	end,
}
