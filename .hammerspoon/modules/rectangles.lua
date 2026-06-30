hs.window.animationDuration = 0
hs.hotkey.bind({ CTRL, SUPER }, "W", function()
	local win = hs.window.focusedWindow()
	local window_frame = win:frame()
	local screen = win:screen():frame()

	window_frame.x = 3
	window_frame.y = 3
	window_frame.w = screen.w / 3 * 2 - 6
	window_frame.h = screen.h - 6

	win:setFrame(window_frame)
end)

hs.hotkey.bind({ CTRL, SUPER }, "E", function()
	local win = hs.window.focusedWindow()
	local window_frame = win:frame()
	local screen = win:screen():frame()
	local remainder = screen.w / 3

	window_frame.x = remainder / 2 - 3
	window_frame.y = 3
	window_frame.w = screen.w / 3 * 2
	window_frame.h = screen.h - 6

	win:setFrame(window_frame)
end)

hs.hotkey.bind({ CTRL, SUPER }, "R", function()
	local win = hs.window.focusedWindow()
	local window_frame = win:frame()
	local screen = win:screen():frame()
	local remainder = screen.w / 3

	window_frame.x = remainder - 3
	window_frame.y = 3
	window_frame.w = screen.w / 3 * 2
	window_frame.h = screen.h - 6

	win:setFrame(window_frame)
end)

hs.hotkey.bind({ CTRL, SUPER }, "S", function()
	local win = hs.window.focusedWindow()
	local window_frame = win:frame()
	local screen = win:screen():frame()

	window_frame.x = 3
	window_frame.y = 3
	window_frame.w = screen.w / 3
	window_frame.h = screen.h - 6

	win:setFrame(window_frame)
end)

hs.hotkey.bind({ CTRL, SUPER }, "D", function()
	local win = hs.window.focusedWindow()
	local window_frame = win:frame()
	local screen = win:screen():frame()
	local remainder = screen.w / 3

	window_frame.x = remainder - 3
	window_frame.y = 3
	window_frame.w = screen.w / 3
	window_frame.h = screen.h - 6

	win:setFrame(window_frame)
end)

hs.hotkey.bind({ CTRL, SUPER }, "F", function()
	local win = hs.window.focusedWindow()
	local window_frame = win:frame()
	local screen = win:screen():frame()
	local remainder = screen.w / 3

	window_frame.x = remainder * 2
	window_frame.y = 3
	window_frame.w = screen.w / 3
	window_frame.h = screen.h - 6

	win:setFrame(window_frame)
end)
