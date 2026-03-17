install(
	gh("tigh-latte/showoff.nvim")
)
require("showoff").setup({
	input = {
		modes = { "n", "no", "v", "V", "" },
		exclude_keys = { ":" },
	},
	window = {
		enable = true,
		display_in_excluded_mode = true,
	},
	active = true,
})
