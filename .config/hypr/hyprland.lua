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

local hostname = (function()
	local f = io.open("/etc/hostname")
	if not f then
		return ""
	end
	local hname = f:read("*l")
	f:close()
	return hname
end)()

-- before hook.
pcall(require, hostname .. ".before")

-- animations are bad
hl.animation({ leaf = "global", enabled = false })
hl.on("hyprland.start", function()
	hl.exec_cmd("swaybg --image " .. os.getenv("HOME") .. "/Pictures/Wallpapers/forest.png")
	hl.exec_cmd("swayosd-server")
end)

require("modules.bindings")
require("modules.rules")
