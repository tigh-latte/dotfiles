--- Linux-ify the keyboard.
--- Best attempt at having the _exact_ same keyboard layout between
--- my linux machine and MacOS.

local M = {
	cur_base = nil,
	bindings = {},
	listeners = {},
	flip_cmd_ctrl = false,
}

local function bind(binding)
	table.insert(M.bindings, binding)
end

local function assign_keys(base)
	if M.cur_base == base then return end
	M.cur_base = base

	for _, binding in ipairs(M.bindings) do binding:delete() end
	M.bindings = {}

	bind(hs.hotkey.bind({ base }, "/", function()
		require("modules.sfc").dump()
	end))
	bind(hs.hotkey.bind({ base }, "D", function()
		require("modules.sfc").sfc("WezTerm")
	end))
	bind(hs.hotkey.bind({ base }, "F", function()
		require("modules.sfc").sfc("Zen")
	end))
	bind(hs.hotkey.bind({ base }, "W", function()
		require("modules.sfc").sfc("Slack")
	end))
	bind(hs.hotkey.bind({ base }, "C", function()
		require("modules.sfc").sfc("Signal")
	end))
	bind(hs.hotkey.bind({ base }, "B", function()
		local date = os.date("%d-%m-%Y")
		local hour = os.date("%I")
		local rest = os.date("%M:%S%p")
		local str = string.format("%s %d:%s", date, hour, rest):lower()
		hs.alert.show(str)
	end))
	bind(hs.hotkey.bind({ base, "shift" }, "L", function()
		hs.toggleConsole()
	end))
	if base == SUPER then
		bind(hs.hotkey.bind({ CTRL, "shift" }, "C", function()
			local app = hs.application.frontmostApplication()
			if not app then return end
			app:selectMenuItem({ "Edit", "Copy to clipboard" })
		end))
		bind(hs.hotkey.bind({ CTRL, "shift" }, "V", function()
			local app = hs.application.frontmostApplication()
			if not app then return end
			app:selectMenuItem({ "Edit", "Paste from clipboard" })
		end))
	end
end

function M.smart_assign_keys()
	local key = (function()
		local win = hs.window.focusedWindow()
		if not win then return CTRL end
		local app = win:application()
		if not app then return CTRL end
		local title = app:title()
		if not title then return CTRL end
		return title == "WezTerm" and SUPER or CTRL
	end)()
	assign_keys(key)
end

function M.set_modifier_swap()
	local win = hs.window.focusedWindow()
	if not win then
		M.flip_cmd_ctrl = true
		return
	end
	local app = win:application()
	if not app then
		M.flip_cmd_ctrl = true
		return
	end
	local title = app:title()
	if not title then
		M.flip_cmd_ctrl = true
		return
	end
	M.flip_cmd_ctrl = title ~= "WezTerm"
end

function M._on_application_change(_, event, _)
	if event == hs.application.watcher.activated or event == hs.application.watcher.launched then
		M.smart_assign_keys()
		M.set_modifier_swap()
	end
end

function M._on_key(event)
	local flags = event:getFlags()

	if M.flip_cmd_ctrl and flags.ctrl ~= flags.cmd then
		flags.ctrl = not flags.ctrl
		flags.cmd = not flags.cmd
		event:setFlags(flags)
	end

	-- if cmd+tab is held on its own in firefox, then do ctrl + tab.
	local key = hs.keycodes.map[event:getKeyCode()]
	if key == "tab" and flags.cmd and (not flags.alt and not flags.ctrl) then
		local current_app = hs.application.frontmostApplication()
		local browser = {
			Firefox = true,
			Zen = true,
		}
		if current_app and browser[current_app:name()] then
			flags.ctrl = true
			flags.cmd = false
			event:setFlags(flags)
		end
	end

	-- if cmd + backspace/left/right, act on a single word instead of the whole
	-- input
	local targets = { delete = true, left = true, right = true }
	if (flags.cmd ~= flags.alt) and targets[key] then
		flags.cmd = not flags.cmd
		flags.alt = not flags.alt
		event:setFlags(flags)
	end

	-- swap ` and \ as for whatever reason, they're flipped on MacOS.
	if key == "`" then
		event:setKeyCode(hs.keycodes.map["\\"])
	elseif key == [[\]] then
		event:setKeyCode(hs.keycodes.map["`"])
	end

	-- time for some fada remapping
	local raw_event_data = event:rawFlags()
	local ralts = {
		a = "á",
		e = "é",
		i = "í",
		o = "ó",
		u = "ú",
		g = "ġ",
	}
	if flags.alt and not flags.cmd and not flags.ctrl and (raw_event_data & hs.eventtap.event.rawFlagMasks.deviceRightAlternate ~= 0) and ralts[key] then
		local letter = ralts[key]
		if flags.shift then
			letter = ({
				["á"] = "Á",
				["é"] = "É",
				["í"] = "Í",
				["ó"] = "Ó",
				["ú"] = "Ú",
				["ġ"] = "Ġ",
			})[letter] or letter
		end
		event:setUnicodeString(letter)
	end

	return false
end

M.listeners = {
	application = hs.application.watcher.new(M._on_application_change):start(),
	key = hs.eventtap.new({ hs.eventtap.event.types.keyDown, hs.eventtap.event.types.keyUp }, M._on_key):start(),
}

M.set_modifier_swap()
M.smart_assign_keys()

return M
