return {
	---@param config Config
	setup = function(config)
		local wez = require("wezterm") --[[@as Wezterm]]
		local act = wez.action

		config.keys = {
			(table.unpack or unpack)(config.keys),
			{
				key = "c",
				mods = "CTRL | SHIFT",
				action = act.SendString "\x1b[67;6u",
			},
			{
				key = "v",
				mods = "CTRL | SHIFT",
				action = act.SendString "\x1b[86;6u",
			},
		}
	end,
}
