return {
	---@param config Config
	setup = function(config)
		config.enable_tab_bar = false
		config.enable_scroll_bar = false
		config.window_decorations = "NONE"
		config.audible_bell = "Disabled"

		config.window_padding = {
			left = 0,
			right = 0,
			top = 0,
			bottom = 0,
		}
	end,
}
