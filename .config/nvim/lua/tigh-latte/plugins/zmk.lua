return {
	"codethread/qmk.nvim",
	ft = "dts",
	config = function()
		require("qmk").setup({
			name = "glove80",
			variant = "zmk",
			layout = {
				"x x x x x _ _ _ _ _ _ _ _ _ x x x x x",
				"x x x x x x _ _ _ _ _ _ _ x x x x x x",
				"x x x x x x _ _ _ _ _ _ _ x x x x x x",
				"x x x x x x _ _ _ _ _ _ _ x x x x x x",
				"x x x x x x x x x _ x x x x x x x x x",
				"x x x x x _ x x x _ x x x _ x x x x x",
			},
			comment_preview = {
				symbols = {
					tl = "╭",
					tr = "╮",
					bl = "╰",
					br = "╯",
				},
				keymap_overrides = {
					["&layer_td"] = "lowr",
					["iso\\"] = "\\",
					["LS%(N1%)"] = "!",
					["LS%(N2%)"] = '"',
					["LS%(N3%)"] = "£",
					["LS%(N4%)"] = "$",
					["LS%(N5%)"] = "%%",
					["LS%(N6%)"] = "^",
					["LS%(N7%)"] = "&",
					["LS%(N8%)"] = "*",
					["LS%(MINUS%)"] = "_",
					["LS%(SEMI%)"] = ":",
					["LS%(EQUAL%)"] = "+",
					["LS%(NON_US_BSLH%)"] = "|",
					["LS%(BSLH%)"] = "~",
					["RA%(N4%)"] = "€",
					["&magic MAGIC 0"] = "✨",
					["kp_"] = "",
					["DBL_QT"] = [["]],
				},
			},
		})
	end,
}
