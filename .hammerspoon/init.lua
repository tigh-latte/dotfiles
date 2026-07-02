CTRL = "ctrl"
ALT = "alt"
SUPER = "cmd"


hs.hotkey.bind({ SUPER, "alt", "ctrl" }, "R", hs.reload)

hs.hotkey.bind({ SUPER, CTRL }, "L", function()
	hs.caffeinate.lockScreen()
end)

hs.window.switcher.ui.showThumbnails = false
hs.window.switcher.ui.showSelectedThumbnail = false
hs.window.switcher.ui.selectedThumbnailSize = 180
hs.window.switcher.ui.thumbnailSize = 80

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

require("modules.rectangles")
require("modules.clickthrough")
require("modules.modifiers")
require("modules.sfc")
require("modules.audio")

hs.alert.show("Config loaded")
