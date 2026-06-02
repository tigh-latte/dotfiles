hl.on("hyprland.start", function()
	hl.exec_cmd("swaybg --image " .. os.getenv("HOME") .. "/Pictures/Wallpapers/river.jpg")
end)

hl.config({
	input = {
		touchpad = {
			natural_scroll = true,
			tap_to_click = true,
		},
	},
})

hl.monitor({
	output = "eDP-1",
	mode = "2880x1920@60.000999",
	scale = 1.5,
})

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})
