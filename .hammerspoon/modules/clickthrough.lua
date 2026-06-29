--- Allow clickthrough, where clicking on an unfocused window focuses & performs an action
--- instead of just focusing.

local M = {
	in_progress = false,
	virtual_event_number = nil,
	listeners = {
		up = nil,
		down = nil,
		focus = nil,
	},
}

function M._is_virtual(event)
	return M.virtual_event_number == event:getProperty(hs.eventtap.event.properties.mouseEventNumber)
end

function M._on_mouse_up(event)
	M.in_progress = false
	return M._is_virtual(event)
end

function M._on_mouse_down(event)
	if M._is_virtual(event) and not M.in_progress then
		local cursorPos = hs.mouse.absolutePosition()
		local mouseUpEvent = hs.eventtap.event.newMouseEvent(hs.eventtap.event.types.leftMouseUp, cursorPos)
		mouseUpEvent:setProperty(hs.eventtap.event.properties.mouseEventNumber, 1)
		mouseUpEvent:post()
		return false
	end
	M.in_progress = true
	hs.timer.doAfter(0.1, function() M.in_progress = false end)
	return false
end

function M._on_focus_change()
	if not M.in_progress then return end
	local cursorPos = hs.mouse.absolutePosition()
	local mouse_down_event = hs.eventtap.event.newMouseEvent(hs.eventtap.event.types.leftMouseDown, cursorPos)
	M.virtual_event_number = mouse_down_event:getProperty(hs.eventtap.event.properties.mouseEventNumber)
	mouse_down_event:post()
end

M.listeners = {
	up = hs.eventtap.new({ hs.eventtap.event.types.leftMouseUp }, M._on_mouse_up):start(),
	down = hs.eventtap.new({ hs.eventtap.event.types.leftMouseDown }, M._on_mouse_down):start(),
	focus = hs.window.filter.default:subscribe(hs.window.filter.windowFocused, M._on_focus_change),
}

return M
