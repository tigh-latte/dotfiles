M = {
	windows = {},
	listeners = {}
}

function M.dump()
	for app, wins in pairs(M.windows) do
		print(app, "{", table.concat(wins, " "), "}")
	end
end

function M.sfc(app)
	if not M.windows[app] or #M.windows[app] <= 1 then
		hs.application.launchOrFocus(app)
		return
	end

	local current_window = hs.window.focusedWindow()

	local wf = hs.window.filter.new({ [app] = { allowRoles = 'AXStandardWindow' } })
	local windows = wf:getWindows(hs.window.filter.sortByFocusLast)
	if not windows or #windows ~= #M.windows[app] then
		-- hs.alert.show("sfc out of sync")
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

function M._track(win, app)
	if not win:isStandard() then return end
	if win:title() == "Slack" and app == "Slack" then -- huddle window
		local frame = win:frame()
		if frame.h < frame.w / 2 then              -- more huddle window checks
			return
		end
	end
	if not M.windows[app] then M.windows[app] = {} end
	table.insert(M.windows[app], win:id())
end

function M._untrack(win, app)
	if not M.windows[app] then return end
	local wid = win:id()
	for i, id in ipairs(M.windows[app]) do
		if id == wid then
			table.remove(M.windows[app], i)
			break
		end
	end
end

M.listeners = {
	on_create = hs.window.filter.default:subscribe(hs.window.filter.windowCreated, M._track, true),
	on_destroy = hs.window.filter.default:subscribe(hs.window.filter.windowDestroyed, M._untrack),
	on_hidden = hs.window.filter.default:subscribe(hs.window.filter.windowHidden, M._untrack, true),
	on_unhidden = hs.window.filter.default:subscribe(hs.window.filter.windowUnhidden, M._track),
	on_minimise = hs.window.filter.default:subscribe(hs.window.filter.windowMinimized, M._untrack, true),
	on_unminimise = hs.window.filter.new():setDefaultFilter({}):subscribe(hs.window.filter.windowUnminimized, M._track),
}

return M
