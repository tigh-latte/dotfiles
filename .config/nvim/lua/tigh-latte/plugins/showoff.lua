return {
	"tigh-latte/showoff.nvim",
	config = function()
		require("showoff").setup({
			input = {
				modes = { "n", "no", "v", "V", "" },
				exclude_keys = {
					[":"] = true,
				},
			},
			window = {
				enable = true,
			},
			active = true,
		})
	end,
}
