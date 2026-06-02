hl.on("hyprland.start", function()
	hl.exec_cmd("swaybg --image " .. os.getenv("HOME") .. "/Pictures/Wallpapers/forest.png")
end)

hl.monitor({
	output = "DP-2",
	mode = "2560x1440@1440.006",
	scale = 1,
	bitdepth = 10,
})
