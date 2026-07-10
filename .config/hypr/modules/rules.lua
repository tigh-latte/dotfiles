local programs = require "programs"

-- all windows are to float, tiling isn't fun.
hl.window_rule({
	match = { class = ".*" },
	float = true,
})

hl.window_rule({
	match = { class = programs.mail.class },
	workspace = "2",
})

hl.window_rule {
	match = { class = "discord" },
	workspace = "3",
	size = { "monitor_w * 0.664", "monitor_h - 6" },
	move = { "5", "3" },
}

hl.window_rule({
	match = {
		class = programs.steam.class,
		modal = false,
	},
	move = { "monitor_w / 3 * 2 + 2.5", "3" },
	size = { "monitor_w * 0.33", "monitor_h - 6" },
	workspace = "3",
})

for _, prog in ipairs { programs.terminal, programs.browser } do
	hl.window_rule({
		workspace = "1",
		size = { "monitor_w * 0.664", "monitor_h - 6" },
		match = { class = prog.class },
	})
end

for _, prog in ipairs { programs.signal, programs.slack, programs.file_manager } do
	hl.window_rule {
		workspace = 1,
		move = { "monitor_w / 3 * 2 + 2.5", "3" },
		size = { "monitor_w * 0.33", "monitor_h - 6" },
		match = { class = prog.class },
	}
end

hl.window_rule({
	workspace = "5",
	match = { class = programs.orca.class }
})

hl.workspace_rule {
	workspace = "4",
	gaps_in = 0,
	gaps_out = 0,
	no_border = true,
	no_rounding = true,
}

