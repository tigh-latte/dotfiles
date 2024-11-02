return {
	---@param config Config
	setup = function(config)
		config.font_size = 9.0
		if require("wezterm") --[[@as Wezterm]]:hostname() == "laptop" then
			config.font_size = config.font_size
		end

		config.bold_brightens_ansi_colors = "No"
		config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
	end,
}
