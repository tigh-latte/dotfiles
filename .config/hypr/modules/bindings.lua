local programs = require("programs")

local menu = "rofi -show-icons -show combi -modes combi -combi-modes drun,run -display-drun '' -display-run $"
local emoji_picker = [[
	rofi -modi emoji -show emoji -emoji-format '{emoji}' -emoji-mode copy -theme-str 'listview {
		columns: 10;
		lines: 10;
		flow: horizontal;
	}
	element { orientation: vertical; }
	element-icon { size: 48px; horizontal-align: 0.5; }
	element-text { horizontal-align: 0.5; }'
]]

---@param program tigh-latte.hl.Program
---@param opts tigh-latte.hl.ProgramOpts?
local function spawn_or_focus(program, opts)
	return function()
		opts = opts or {}
		opts.should_focus = opts.should_focus or function()
			return true
		end
		opts.should_spawn = opts.should_spawn or function()
			return true
		end

		local cc = {} --- @type HL.Window[]
		local last_focus ---@type HL.Window
		for _, window in ipairs(hl.get_windows({ class = program.class })) do
			if not last_focus or last_focus.focus_history_id > window.focus_history_id then
				last_focus = window
			end
			table.insert(cc, window)
		end
		table.sort(cc, function(a, b)
			return a.stable_id < b.stable_id
		end)

		local target = (function()
			-- if program not running, open new one
			if #cc == 0 then return end

			local current_window = hl.get_active_window()
			if not current_window then return last_focus end

			-- if program is running, and isn't current focused, open last focused
			if current_window.class ~= last_focus.class then return last_focus end

			-- if program is running, and is focused, cycle based on order of open
			for i, c in ipairs(cc) do
				if c.stable_id == current_window.stable_id then
					return cc[i % #cc + 1]
				end
			end
		end)()

		-- by default, setting focus via the lua api moves the mouse to the centre of the window,
		-- when I would prefer it to not move the mouse at all.
		-- grab it's location before permforming any action and return return it to that position.
		local coords = hl.get_cursor_pos()
		if not target then
			if opts.should_spawn() then
				hl.dispatch(hl.dsp.exec_cmd(program.cmd))
			end
		else
			if opts.should_focus() then
				hl.dispatch(hl.dsp.focus({ window = target }))
				hl.dispatch(hl.dsp.window.bring_to_top({ window = target }))
			end
		end
		hl.dispatch(hl.dsp.cursor.move(coords))
	end
end

---@param pos number
---@param ratio number
---@return fun()
local function rectanges(pos, ratio)
	return function()
		local window = hl.get_active_window()
		if not window then return end
		local screen = hl.get_active_monitor()
		if not screen then return end

		local delta = 5 / screen.scale

		local width = screen.width * ratio - (delta + 2)
		local height = screen.height - 6

		local available = screen.width - width
		local offset = delta * 2 * (0.5 - pos)
		local x = (available * pos) + offset

		hl.dispatch(hl.dsp.window.resize({ x = width / screen.scale, y = height / screen.scale, window = window }))
		hl.dispatch(hl.dsp.window.move({ x = x / screen.scale, y = 3 / screen.scale, window = window }))
	end
end

hl.bind("SUPER + f", spawn_or_focus(programs.browser))
hl.bind("SUPER + d", spawn_or_focus(programs.terminal))
hl.bind("SUPER + e", spawn_or_focus(programs.file_manager))
hl.bind("SUPER + c", spawn_or_focus(programs.signal))
hl.bind("SUPER + g", spawn_or_focus(programs.steam))
hl.bind("SUPER + t", spawn_or_focus(programs.mail))
hl.bind("SUPER + z", function() hl.dispatch(hl.dsp.window.float()) end)
hl.bind("SUPER + SHIFT + f", function()
	local screen = hl.get_active_monitor()
	if not screen then return end
	hl.dispatch(hl.dsp.window.resize({ x = screen.width / screen.scale - 6, y = screen.height / screen.scale - 6 }))
	hl.dispatch(hl.dsp.window.move({ x = 3, y = 3 }))
end)


hl.bind("SUPER + o", spawn_or_focus(programs.orca))

for i = 1, 9 do
	local ws = tostring(i)
	hl.bind("SUPER + " .. ws, hl.dsp.focus({ workspace = ws }))
	hl.bind("SUPER + SHIFT + " .. ws, hl.dsp.window.move({ workspace = ws, follow = false }))
end
hl.bind("ALT + Space", hl.dsp.exec_cmd(menu))
hl.bind("ALT + F4", hl.dsp.window.close(hl.get_active_window()))
hl.bind("SUPER + CTRL + q", hl.dsp.window.close(hl.get_active_window()))
hl.bind("ALT + Return", hl.dsp.exec_cmd(emoji_picker))
hl.bind("Print", hl.dsp.exec_cmd('grim -g "$(slurp)" - | wl-copy'))

-- volume
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("swayosd-client --output-volume mute-toggle"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("swayosd-client --output-volume lower"))
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("swayosd-client --output-volume raise"))

-- brightness
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("swayosd-client --brightness lower"))
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("swayosd-client --brightness raise"))

-- media
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))

-- positioning
hl.bind("SUPER + CTRL + w", rectanges(0, 2 / 3))
hl.bind("SUPER + CTRL + e", rectanges(0.5, 2 / 3))
hl.bind("SUPER + CTRL + r", rectanges(1, 2 / 3))
hl.bind("SUPER + CTRL + s", rectanges(0, 1 / 3))
hl.bind("SUPER + CTRL + d", rectanges(0.5, 1 / 3))
hl.bind("SUPER + CTRL + f", rectanges(1, 1 / 3))

-- notifications
hl.bind("SUPER + SHIFT + n", hl.dsp.exec_cmd("swaync-client -t -sw"))

-- quick debugging
hl.bind("SUPER + CTRL + n", function()
	for _, window in ipairs(hl.get_windows()) do
		hl.notification.create({ text = window.class, timeout = 3000 })
	end
end)

hl.bind("ALT + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("ALT + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("SUPER + b", hl.dsp.exec_cmd("/home/tigh/.cargo/bin/lush toggle bar"))

local function jump_workspace(delta)
	local workspace = hl.get_active_workspace()
	if not workspace then return end
	local next = tonumber(workspace.name) % 9 + delta
	if next < 1 then next = 9 end
	hl.dispatch(hl.dsp.focus({ workspace = tostring(next) }))
end

hl.bind("SUPER + mouse_down", function() jump_workspace(1) end)
hl.bind("SUPER + mouse_up", function() jump_workspace(-1) end)
hl.bind("ALT + mouse_right", function() jump_workspace(1) end)
hl.bind("ALT + mouse_left", function() jump_workspace(-1) end)

hl.bind("SUPER + b", function()
	local date = tostring(os.date("%Y-%m-%d %I:%M:%S%p"))
	hl.notification.create({ text = date, timeout = 2500 })
end)
