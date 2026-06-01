local programs = require "programs"

hl.window_rule({
	match = { class = ".*" },
	float = true,
})

hl.window_rule({
	match = {
		class = programs.mail.class,
	},
	workspace = "2",
})
hl.window_rule({
	match = {
		class = programs.steam.class,
	},
	workspace = "3",
})

hl.window_rule({
	workspace = "1",
	size = { "monitor_w * 0.66", "monitor_h - 10" },
	match = {
		class = programs.browser.class,
	},
})

hl.workspace_rule({
	workspace = "4",
	gaps_in = 0,
	gaps_out = 0,
	no_border = true,
	no_rounding = true,
})
hl.window_rule({
	workspace = "4",
	match = {
		class = "^steam_app_[0-9]+",
	},
})

hl.window_rule({
	workspace = "5",
	match = { class = programs.orca.class }
})
