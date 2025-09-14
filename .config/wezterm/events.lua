local wezterm = require("wezterm") --[[@as Wezterm]]

---@param overrides Config
---@param prog string|nil
---@param target string|nil
local function build_override(overrides, prog, target)
	if prog ~= "ssh" then
		overrides.window_background_gradient = nil
		overrides.background = nil
		return
	end

	local io = require("io")
	local target_png = wezterm.config_dir .. "/sshtargets/" .. target .. ".png"
	local f = io.open(target_png)
	if not f then
		overrides.window_background_gradient = nil
		overrides.background = nil
		return
	end
	f:close()

	overrides.window_background_gradient = {
		colors = {
			"#212121",
			"#490500",
		},
		orientation = "Horizontal",
		interpolation = "Linear",
		blend = "Rgb",
	}
	overrides.background = { {
		source = {
			File = target_png,
		},
		repeat_x = "NoRepeat",
		repeat_y = "NoRepeat",
		width = "20%",
		height = "20%",
		vertical_align = "Bottom",
		horizontal_align = "Right",
	} }
end

local M = {
	state = {
		tty = "",
		fgproc = "",
	},
}

function M.setup(config)
	-- On update status, I want to check for the currently running command, along with
	-- its arugments. The idea is to modify wezterm in a way that makes sense for the context,
	-- so if I am ssh'd into a server which I don't want to be running destructive commands on,
	-- or if i am connected to an important database.
	wezterm.on("update-status", function(window, _)
		local success, tty_stdout, _ = wezterm.run_child_process { "tmux", "display", "-p", "#{pane_tty}" }
		if not success then return end
		tty_stdout = tty_stdout:sub(1, #tty_stdout - 1)

		local stdout
		success, stdout, _ = wezterm.run_child_process { "ps", "-o", "stat=,args=", "-t", tty_stdout }
		if not success then return end
		stdout = stdout:sub(1, #stdout - 1)

		local prog
		local args = {}
		for fproc in stdout:gmatch("%+.+") do
			for item in fproc:gmatch("[^+%s]+") do
				if prog == nil then
					prog = item
				else
					table.insert(args, item)
				end
			end
		end

		if M.state.tty == tty_stdout and M.state.fgproc == prog then
			return
		end
		M.state.tty = tty_stdout
		M.state.fgproc = prog

		local overrides = window:get_config_overrides() or {}
		overrides.colors = overrides.colors or config.colors

		build_override(overrides, prog, table.concat(args, " "))
		window:set_config_overrides(overrides)
	end)
end

return M
