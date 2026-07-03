---@module "wezterm"

wezterm.on('window-config-reloaded', function(window, pane)
	local dimensions = window:get_dimensions()
	if dimensions.dpi == 144 then
		local overrides = window:get_config_overrides()
		overrides.font_size = 11.0
		window:set_config_overrides(overrides)
	end
end)


return {
	---@param config Config
	setup = function(config)
		config.font_size = 12.0
	end,
}
