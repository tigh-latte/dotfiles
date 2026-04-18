vim.pack.add {
	gh "nvzone/volt",
	gh "gisketch/triforce.nvim",
}

require("triforce").setup({
	notifications = { enabled = false },

	custom_languages = {
		cucumber = { icon = "", name = "gherkin" },
	},
})
