return {
	---@param config Config
	setup = function(config)
		---@module 'wezterm'

		config.enable_tab_bar = false
		config.enable_scroll_bar = false
		config.window_decorations = "NONE"

		config.audible_bell = "Disabled"
		config.visual_bell = {
			fade_in_duration_ms = 150,
			fade_out_duration_ms = 150,
			fade_in_function = "Ease",
			fade_out_function = "Ease",
			target = "CursorColor",
		}

		config.default_cursor_style = "SteadyBlock"

		config.adjust_window_size_when_changing_font_size = false

		config.window_padding = {
			left = 0,
			right = 0,
			top = 0,
			bottom = 0,
		}

		-- initial rows like Alacritty.
		config.initial_rows = 34
		config.initial_cols = 114
	end,
}
