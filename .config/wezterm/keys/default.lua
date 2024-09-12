local act = require("wezterm") --[[@as Wezterm]].action

local keys = {}

local first_char = string.byte("a")
local first_ansii = 65
local char_offset = first_char - first_ansii

for i = first_ansii, first_ansii + 25 do
	table.insert(keys, {
		key = string.char(i + char_offset),
		mods = "CTRL | SHIFT",
		action = act.SendString("\x1b[" .. tostring(i) .. ";6u"),
	})
end

for _, char in pairs({ "v", "c" }) do
	local pos = string.byte(char) - first_char + 1
	table.remove(keys, pos)
end


return keys
