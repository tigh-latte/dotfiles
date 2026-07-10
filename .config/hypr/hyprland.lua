hl.config({
	general = {
		gaps_in = 3,
		gaps_out = 3,
		col = { active_border = "#6D6C6C" },
	},
	decoration = {
		blur = { enabled = false },
		shadow = { enabled = false },
	},
	input = {
		kb_layout = "gb",
		kb_variant = "extd",
		repeat_rate = 35,
		repeat_delay = 450,
		follow_mouse = 2,
	},
})

-- animations are bad
hl.animation({ leaf = "global", enabled = false })
hl.on("hyprland.start", function() hl.exec_cmd("swayosd-server") end)

require("modules.device")
require("modules.bindings")
require("modules.rules")

hl.notification.create({ text = "config loaded", timeout = 1500 })
