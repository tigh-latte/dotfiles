local M = {
	windows = {},
	listeners = {}
}

function M.sfc(app)
	if not M.windows[app] or #M.windows[app] <= 1 then
		hs.application.launchOrFocus(app)
		return
	end

	local current_window = hs.window.focusedWindow()
	local current_app = current_window and current_window:application()

	local wf = hs.window.filter.new({ app })
	local windows = wf:getWindows(hs.window.filter.sortByFocusLast)
	if not windows or #windows ~= #M.windows[app] then
		hs.alert.show("sfc out of sync")
	end
	local last_focused = windows[1]
	if last_focused:id() ~= current_window:id() then
		last_focused:focus()
		return
	end
	local app_ids = M.windows[app]
	for i, id in ipairs(app_ids) do
		if id == current_window:id() then
			hs.window.find(app_ids[i % #app_ids + 1]):focus()
			return
		end
	end
end

M.listeners = {
	on_create = hs.window.filter.default:subscribe(hs.window.filter.windowCreated, function(win, app, _)
		if not M.windows[app] then
			M.windows[app] = {}
		end
		table.insert(M.windows[app], win:id())
	end, true),
	on_destroy = hs.window.filter.default:subscribe(hs.window.filter.windowDestroyed, function(win, app, _)
		if not M.windows[app] then return end
		local wid = win:id()
		for i, id in ipairs(M.windows[app]) do
			if id == wid then
				table.remove(M.windows[app], i)
				break
			end
		end
	end),
}

return M
