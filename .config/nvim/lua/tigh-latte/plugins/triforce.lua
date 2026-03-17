vim.pack.add({
	"https://github.com/nvzone/volt",
	"https://github.com/gisketch/triforce.nvim",
})

require("triforce").setup({
	notifications = { enabled = false },

	custom_languages = {
		cucumber = { icon = "", name = "gherkin" },
	},
})
