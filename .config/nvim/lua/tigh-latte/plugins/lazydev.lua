return {
	{
		"folke/lazydev.nvim",
		config = function()
			require("lazydev").setup({
				library = {
					{ path = "",              words = { "vim%.uv" } },
					{ path = "wezterm-types", mods = { "wezterm" } },
				},

			})
		end,
	},
	{ "Bilal2453/luvit-meta",        lazy = true },
	{ "justinsgithub/wezterm-types", lazy = true },
}
