local wezterm = require("wezterm") --[[@as Wezterm]]

---@param overrides Config
---@param target string|nil
local function build_override(overrides, target)
	if not target then
		overrides.window_background_gradient = nil
		overrides.background = nil
		return
	end

	local io = require("io")
	local target_png = wezterm.config_dir .. "/sshtargets/" .. target .. ".png"
	local f = io.open(target_png)
	if not f then
		overrides.window_background_gradient = nil
		overrides.background = nil
		return
	end
	f:close()

	overrides.window_background_gradient = {
		colors = {
			"#212121",
			"#490500",
		},
		orientation = "Horizontal",
		interpolation = "Linear",
		blend = "Rgb",
	}
	overrides.background = { {
		source = {
			File = target_png,
		},
		repeat_x = "NoRepeat",
		repeat_y = "NoRepeat",
		width = "20%",
		height = "20%",
		vertical_align = "Bottom",
		horizontal_align = "Right",
	} }
end

return {
	setup = function(config)
		wezterm.on("user-var-changed", function(window, _, key, value)
			local overrides = window:get_config_overrides() or {}
			overrides.colors = overrides.colors or config.colors

			if key ~= "ssh" then return end

			build_override(overrides, value)

			window:set_config_overrides(overrides)
		end)
	end,
}
