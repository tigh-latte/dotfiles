return {
	{ "Bilal2453/luvit-meta",     lazy = true },
	{ "tigh-latte/wezterm-types", lazy = true },
	{
		"folke/lazydev.nvim",
		ft = "lua",
		config = function()
			require("lazydev").setup({
				---@type lazydev.Library.spec
				library = {
					{ path = "luvit-meta/library", words = { "vim%.uv" } },
					{ path = "wezterm-types",      mods = { "wezterm" } },
				},
			})
		end,
	},
}
