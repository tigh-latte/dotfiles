local programs = require "programs"

-- all windows are to float, tiling isn't fun.
hl.window_rule({
	match = { class = ".*" },
	float = true,
})

hl.window_rule({
	match = { class = programs.mail.class },
	workspace = "2",
})

hl.window_rule {
	match = { class = "discord" },
	workspace = "3",
	size = { "monitor_w * 0.664", "monitor_h - 6" },
	move = { "5", "3" },
}

hl.window_rule({
	match = {
		class = programs.steam.class,
		modal = false,
	},
	move = { "monitor_w / 3 * 2 + 2.5", "3" },
	size = { "monitor_w * 0.33", "monitor_h - 6" },
	workspace = "3",
})

for _, prog in ipairs { programs.terminal, programs.browser } do
	hl.window_rule({
		workspace = "1",
		size = { "monitor_w * 0.664", "monitor_h - 6" },
		match = { class = prog.class },
	})
end

for _, prog in ipairs { programs.signal, programs.slack, programs.file_manager } do
	hl.window_rule {
		workspace = 1,
		move = { "monitor_w / 3 * 2 + 2.5", "3" },
		size = { "monitor_w * 0.33", "monitor_h - 6" },
		match = { class = prog.class },
	}
end

hl.window_rule({
	workspace = "5",
	match = { class = programs.orca.class }
})

hl.workspace_rule {
	workspace = "4",
	gaps_in = 0,
	gaps_out = 0,
	no_border = true,
	no_rounding = true,
}

-- the workspace of a rule doesn't appear to applied after a window is opened, meaning
-- listening for a tag on the window to move a window to a workspace won't work.
-- Instead, use a dispatch to set the workspace.
---@param win HL.Window
hl.on("window.open", function(win)
	local function launched_by_steam(pid, depth)
		if not depth then depth = 1 end
		if depth == 10 then return false end
		if not pid or pid <= 0 then return false end

		local pfile = "/proc/" .. tostring(pid) .. "/stat"
		local ok, f = pcall(io.open, pfile, "r")
		if not ok then return false end
		if not f then return false end
		local contents = f:read("*a") --[[@as string]]
		f:close()
		if not contents or contents == "" then return false end

		if contents:find("^" .. pid .. " %(steam%)") or contents:find("^" .. pid .. " %(steamwebhelper%)") then
			return depth > 1
		end
		local parent = contents:match "%) %s*%S+%s*(%d+)"
		if not parent then return false end
		return launched_by_steam(tonumber(parent), depth + 1)
	end

	if launched_by_steam(win.pid) then
		hl.dispatch(hl.dsp.window.tag({ tag = "steam_game", window = win }))
		hl.dispatch(hl.dsp.window.move({ workspace = "4", follow = true, window = win }))
	end
end)
