local wez = require("wezterm") --[[@as Wezterm]]
local act = wez.action

return { {
	key = "c",
	mods = "CTRL | SHIFT",
	action = act.SendString "\x1b[67;6u",
}, {
	key = "v",
	mods = "CTRL | SHIFT",
	action = act.SendString "\x1b[86;6u",
} }
