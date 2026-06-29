local CTRL = "ctrl"
local ALT = "alt"
local SUPER = "cmd"

hs.window.animationDuration = 0

hs.hotkey.bind({ SUPER, "alt", "ctrl" }, "R", hs.reload)

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

hs.hotkey.bind({ SUPER, CTRL }, "L", function()
	hs.caffeinate.systemSleep()
end)

hs.window.switcher.ui.showThumbnails = false
hs.window.switcher.ui.showSelectedThumbnail = false
hs.window.switcher.ui.selectedThumbnailSize = 180
hs.window.switcher.ui.thumbnailSize = 80

local switcher = hs.window.switcher.new()

hs.hotkey.bind(ALT, "tab", hs.window.switcher.nextWindow)
hs.hotkey.bind(ALT .. "-shift", "tab", hs.window.switcher.previousWindow)

config_reloader = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", function(files)
	local reload = false
	for _, file in pairs(files) do
		if file:sub(-4) == ".lua" then
			reload = true
			break
		end
	end
	if reload then hs.reload() end
end):start()

hs.hotkey.bind({ SUPER }, "Q", function() end)
hs.hotkey.bind({ SUPER, CTRL }, "Q", function()
	local win = hs.window.focusedWindow()
	if not win then return end
	local app = win:application()
	if not app then return end
	app:kill()
end)

inverse_mouse = hs.eventtap.new({ hs.eventtap.event.types.scrollWheel }, function(event)
	local isContinuous = event:getProperty(hs.eventtap.event.properties.scrollWheelEventIsContinuous)
	if isContinuous == 1 then return false end --trackpad, do nothing

	local scrollY = event:getProperty(hs.eventtap.event.properties.scrollWheelEventDeltaAxis1)
	event:setProperty(hs.eventtap.event.properties.scrollWheelEventDeltaAxis1, -scrollY)
	return false
end):start()

local function set_wallpaper()
	for _, screen in ipairs(hs.screen.allScreens()) do
		screen:desktopImageURL("file://" .. os.getenv("HOME") .. "/Pictures/Wallpapers/forest.png")
	end
end

set_wallpaper()

if not hs.keycodes.setLayout("British – PC") then
	hs.alert.show("Keyboard layout not set correctly. Enable in MacOS settings.")
end

require("modules.clickthrough")
require("modules.modifiers")

hs.alert.show("Config loaded")
