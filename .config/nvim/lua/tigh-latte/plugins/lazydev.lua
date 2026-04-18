vim.pack.add {
	gh "Bilal2453/luvit-meta",
	gh "tigh-latte/wezterm-types",
	gh "folke/lazydev.nvim",
}

vim.api.nvim_create_autocmd("BufRead", {
	pattern = "*.lua",
	once = true,
	callback = function()
		require("lazydev").setup({
			---@type lazydev.Library.spec
			library = {
				{ path = "${3rd}/luv/library",           words = { "vim%.uv" } },
				{ path = "wezterm-types",                mods = { "wezterm" } },
				{ path = "/usr/local/share/somewm/lua/", mods = { "awful" } },
			},
		})
	end,
})
