return {
	---@param config Config
	setup = function(config)
		local act = wezterm.action

		-- Allow vim to handle CTRL+^
		local keys = {}

		local first_char = string.byte("a")
		local first_ansii = 65
		local char_offset = first_char - first_ansii

		-- Enable CTRL + SHIFT + [a-z]
		for i = first_ansii, first_ansii + 25 do
			table.insert(keys, {
				key = string.char(i + char_offset),
				mods = "CTRL | SHIFT",
				action = act.SendString("\x1b[" .. tostring(i) .. ";6u"),
			})
		end

		-- Don't bind over the top of CTRL + SHIFT + [cv]
		for _, char in pairs({ "v", "c" }) do
			local pos = string.byte(char) - first_char + 1
			table.remove(keys, pos)
		end
		table.insert(keys, {
			key = "^",
			mods = "CTRL | SHIFT",
			action = act.DisableDefaultAssignment,
		})

		table.insert(keys, {
			key = ",",
			mods = "CTRL",
			action = act.SendString("\x1b[" .. tostring(string.byte(",")) .. ";6u"),
		})
		table.insert(keys, {
			key = "(",
			mods = "CTRL | SHIFT",
			action = act.SendString("\x1b[" .. tostring(string.byte("(")) .. ";6u"),
		})
		table.insert(keys, {
			key = ")",
			mods = "CTRL | SHIFT",
			action = act.SendString("\x1b[" .. tostring(string.byte(")")) .. ";6u"),
		})

		table.insert(keys, {
			key = "L",
			mods = "ALT | SHIFT",
			action = act.ShowDebugOverlay,
		})

		table.insert(keys, { -- Send ctrl+backspace as shift+delete as for it to be handled.
			key = "Backspace",
			mods = "CTRL",
			action = act.SendString "\x1b[3;6~"
		})

		config.keys = keys
	end,
}
