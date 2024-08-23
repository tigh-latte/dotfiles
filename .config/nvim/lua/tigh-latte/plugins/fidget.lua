return {
	"j-hui/fidget.nvim",
	config = function()
		require("fidget").setup({
			notification = {
				window = {
					winblend = 0,
					y_padding = 3,
				},
			},
		})
	end,
}
