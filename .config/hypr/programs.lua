---@class tigh-latte.hl.Program
---@field cmd string
---@field class string

---@class tigh-latte.hl.ProgramOpts
---@field should_spawn? fun(): boolean
---@field should_focus? fun(): boolean

---@type table<string, tigh-latte.hl.Program>
local M = {}

M.signal = {
	cmd = "gtk-launch signal-desktop.desktop",
	class = "signal",
}

M.slack = {
	cmd = "slack",
	class = "slack",
}

M.wezterm = {
	cmd = "wezterm",
	class = "org.wezfurlong.wezterm",
}

M.librewolf = {
	cmd = "librewolf",
	class = "librewolf",
}

M.steam = {
	cmd = "steam",
	class = "steam",
}

M.steam_app = {
	cmd = "steam",
	class = "steam_app",
}

M.tutanota = {
	cmd = "/opt/tutanota-desktop/tutanota-desktop",
	class = "tutanota-desktop",
}

M.emulator_3ds = {
	cmd = "azahar",
	class = "Azahar",
}

M.orca = {
	cmd = "/opt/orca-slicer/AppRun",
	class = "OrcaSlicer",
}

M.file_manager = {
	cmd = "nautilus",
	class = "org.gnome.Nautilus",
}

M.terminal = M.wezterm
M.browser = M.librewolf
M.current_game = M.steam_app
M.mail = M.tutanota

return M
