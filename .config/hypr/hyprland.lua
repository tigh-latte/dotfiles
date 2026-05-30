-- Keyboard
hl.config({
	general = {
		gaps_in = 3,
		gaps_out = 3,
		col = {
			active_border = "#6D6C6C",
		},
	},
	input = {
		kb_layout = "gb",
		kb_variant = "extd",
		repeat_rate = 35,
		repeat_delay = 450,
		follow_mouse = 2,
	},
})

local hostname = (function()
	local f = io.open("/etc/hostname")
	if not f then
		return ""
	end
	local hname = f:read("*l")
	f:close()
	return hname
end)()

-- before hook.
pcall(require, hostname .. ".before")

-- animations are bad
hl.animation({ leaf = "global", enabled = false })

local file_manager = "nautilus"
local menu = "rofi -show-icons -show combi -modes combi -combi-modes drun,run -display-drun '' -display-run $"

-- hl.workspace_rule({ workspace = "1", gaps_in = 3, gaps_out = 3})

hl.on("hyprland.start", function()
	hl.exec_cmd("swaybg --image " .. os.getenv("HOME") .. "/Pictures/Wallpapers/forest.png")
	hl.exec_cmd("swayosd-server")
end)

hl.on("window.open", function(w)
	-- hl.dispatch(hl.dsp.window.float(w))
end)

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

		--- @type HL.Window[]
		local cc = {}
		--- @type HL.Window
		local last_focus
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
			if #cc == 0 then
				return
			end

			local current_window = hl.get_active_window()
			if not current_window then
				return last_focus
			end

			-- if program is running, and isn't current focused, open last focused
			if current_window.class ~= last_focus.class then
				return last_focus
			end

			-- if program is running, and is focused, cycle based on order of open
			for i, c in ipairs(cc) do
				if c.stable_id == current_window.stable_id then
					local next = cc[i % #cc + 1]
					return next
				end
			end
		end)()

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
	end
end

-- Program launching
local programs = require("programs")
hl.bind("SUPER + f", spawn_or_focus(programs.browser))
hl.bind("SUPER + d", spawn_or_focus(programs.terminal))
hl.bind("SUPER + e", hl.dsp.exec_cmd(file_manager))
hl.bind("SUPER + c", spawn_or_focus(programs.signal))
hl.bind("SUPER + g", spawn_or_focus(programs.steam))
hl.bind("SUPER + z", function()
	hl.dispatch(hl.dsp.window.float())
end)
hl.bind(
	"SUPER + w",
	spawn_or_focus(programs.slack, {
		should_spawn = function()
			local day = tonumber(os.date("%w"))
			local hour = tonumber(os.date("%H"))
			return day <= 5 and (7 <= hour and hour < 17)
		end,
	})
)

hl.window_rule({
	match = {
		class = programs.mail.class,
	},
	workspace = "2",
})
hl.window_rule({
	match = {
		class = programs.steam.class,
	},
	workspace = "3",
})

hl.window_rule({
	workspace = "1",
	float = true,
	size = { "monitor_w * 0.66", "monitor_h - 10" },
	match = {
		class = programs.browser.class,
	},
})

for i = 1, 9 do
	hl.bind("SUPER + " .. tostring(i), hl.dsp.focus({ workspace = tostring(i) }))
	hl.bind("SUPER + SHIFT + " .. tostring(i), hl.dsp.window.move({ workspace = tostring(i), follow = false }))
end
hl.bind("ALT + Space", hl.dsp.exec_cmd(menu))
hl.bind("ALT + F4", hl.dsp.window.close(hl.get_active_window()))
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

---@param pos "left"|"middle"|"right"
---@param ratio number
---@return fun()
local function rectanges(pos, ratio)
	return function()
		local window = hl.get_active_window()
		if not window then
			return
		end
		local screen = hl.get_active_monitor()
		if not screen then
			return
		end

		local delta = 5

		local width = screen.width * ratio - (delta + 2)
		local height = screen.height - 6

		local available = screen.width - width
		local x = 0
		if pos == "left" then
			x = 0 + delta
		elseif pos == "middle" then
			x = available * 0.5
		else
			x = available - delta
		end

		hl.dispatch(hl.dsp.window.resize({ x = width, y = height, window = window }))
		hl.dispatch(hl.dsp.window.move({ x = x, y = 3, window = window }))
	end
end
hl.bind("SUPER + CTRL + w", rectanges("left", 2 / 3))
hl.bind("SUPER + CTRL + e", rectanges("middle", 2 / 3))
hl.bind("SUPER + CTRL + r", rectanges("right", 2 / 3))

hl.bind("SUPER + CTRL + s", rectanges("left", 1 / 3))
hl.bind("SUPER + CTRL + d", rectanges("middle", 1 / 3))
hl.bind("SUPER + CTRL + f", rectanges("right", 1 / 3))
