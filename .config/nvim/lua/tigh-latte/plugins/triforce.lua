return {
	"gisketch/triforce.nvim",
	dependencies = { "nvzone/volt" },
	config = function()
		require("triforce").setup({
			notifications = {
				enabled = false,
			},

			custom_languages = {
				cucumber = {
					icon = "",
					name = "Gherkin",
				},
			},
		})
	end,
}
