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
					{ path = "${3rd}/luv/library",           words = { "vim%.uv" } },
					{ path = "wezterm-types",                mods = { "wezterm" } },
					{ path = "/usr/local/share/somewm/lua/", mods = { "awful" } },
				},
			})
		end,
	},
}
