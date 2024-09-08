local wezterm = require("wezterm") --[[@as Wezterm]]

local config = wezterm.config_builder()

local unpack = table.unpack or unpack

config.enable_tab_bar = false
config.enable_scroll_bar = false
config.window_decorations = "NONE"
config.font_size = 9.0

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
		"#8abeb7",
		"#c5c8c6",
	},
	foreground = "#d7d7d7",
	indexed = {},
	cursor_fg = "#212121",
	cursor_bg = "#e4e4e4",
	cursor_border = "#e4e4e4",
}


config.bold_brightens_ansi_colors = "No"

config.keys = require("keys.default")

setmetatable({
	["aarch64-apple-darwin"] = function()
		config.keys = {
			unpack(config.keys),
			unpack(require("keys.apple"), 1),
		}
	end,
	["x86_64-unknown-linux-gnu"] = function()
	end,
}, {
	__index = function(_, key)
		wezterm.log_error("unknown operating system: " .. key)
	end,
})[wezterm.target_triple]()


return config
