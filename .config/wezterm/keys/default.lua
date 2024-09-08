local wez = require("wezterm") --[[@as Wezterm]]
local act = wez.action

return { {
	key = "a",
	mods = "CTRL | SHIFT",
	action = act.SendString "\x1b[65;6u",
}, {
	key = "b",
	mods = "CTRL | SHIFT",
	action = act.SendString "\x1b[66;6u",
}, {
	key = "d",
	mods = "CTRL | SHIFT",
	action = act.SendString "\x1b[68;6u",
}, {
	key = "e",
	mods = "CTRL | SHIFT",
	action = act.SendString "\x1b[69;6u",
}, {
	key = "f",
	mods = "CTRL | SHIFT",
	action = act.SendString "\x1b[70;6u",
}, {
	key = "g",
	mods = "CTRL | SHIFT",
	action = act.SendString "\x1b[71;6u",
}, {
	key = "h",
	mods = "CTRL | SHIFT",
	action = act.SendString "\x1b[72;6u",
}, {
	key = "i",
	mods = "CTRL | SHIFT",
	action = act.SendString "\x1b[73;6u",
}, {
	key = "j",
	mods = "CTRL | SHIFT",
	action = act.SendString "\x1b[74;6u",
}, {
	key = "k",
	mods = "CTRL | SHIFT",
	action = act.SendString "\x1b[75;6u",
}, {
	key = "l",
	mods = "CTRL | SHIFT",
	action = act.SendString "\x1b[76;6u",
}, {
	key = "m",
	mods = "CTRL | SHIFT",
	action = act.SendString "\x1b[77;6u",
}, {
	key = "n",
	mods = "CTRL | SHIFT",
	action = act.SendString "\x1b[78;6u",
}, {
	key = "o",
	mods = "CTRL | SHIFT",
	action = act.SendString "\x1b[79;6u",
}, {
	key = "p",
	mods = "CTRL | SHIFT",
	action = act.SendString "\x1b[80;6u",
}, {
	key = "q",
	mods = "CTRL | SHIFT",
	action = act.SendString "\x1b[81;6u",
}, {
	key = "r",
	mods = "CTRL | SHIFT",
	action = act.SendString "\x1b[82;6u",
}, {
	key = "s",
	mods = "CTRL | SHIFT",
	action = act.SendString "\x1b[83;6u",
}, {
	key = "t",
	mods = "CTRL | SHIFT",
	action = act.SendString "\x1b[84;6u",
}, {
	key = "u",
	mods = "CTRL | SHIFT",
	action = act.SendString "\x1b[85;6u",
}, {
	key = "w",
	mods = "CTRL | SHIFT",
	action = act.SendString "\x1b[87;6u",
}, {
	key = "x",
	mods = "CTRL | SHIFT",
	action = act.SendString "\x1b[88;6u",
}, {
	key = "y",
	mods = "CTRL | SHIFT",
	action = act.SendString "\x1b[89;6u",
}, {
	key = "z",
	mods = "CTRL | SHIFT",
	action = act.SendString "\x1b[90;6u",
} }
