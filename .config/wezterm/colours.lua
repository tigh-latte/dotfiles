return {
	---@param config Config
	setup = function(config)
		config.colors = {
			ansi = {
				"#282a2e",
				"#af5f5a",
				"#53891c",
				"#d7af87",
				"#5fafaf",
				"#af87af",
				"#5e8d87",
				"#707880",
			},
			background = "#212121",
			brights = {
				"#373b41",
				"#af5f5a",
				"#53891c",
				"#d7af87",
				"#5fafaf",
				"#af87af",
				"#5e8d87",
				"#707880",
			},
			foreground = "#d7d7d7",
			indexed = {},
			cursor_fg = "#212121",
			cursor_bg = "#e4e4e4",
			cursor_border = "#e4e4e4",
		}
	end,
}
