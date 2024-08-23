return {
	{
		"folke/lazydev.nvim",
		ft = "lua",
		config = function()
			require("lazydev").setup({
				library = {
					{ path = "", words = { "vim%.uv" } },
				},
			})
		end,
	},
	{
		"Bilal2453/luvit-meta",
		lazy = true,
	},
}
