---@class tigh-latte.some.Program
---@field cmd string[]
---@field class string

---@type table<string, tigh-latte.some.Program>
local M = {}

M.signal = {
    cmd = { "gtk-launch", "signal-desktop.desktop" },
    class = "^signal$",
}

M.slack = {
    cmd = { "slack" },
    class = "^slack$",
}

M.wezterm = {
    cmd = { "wezterm" },
    class = "wezterm$",
}

M.librewolf = {
    cmd = { "librewolf" },
    class = "^librewolf$",
}

M.steam = {
    cmd = { "steam" },
    class = "^steam$",
}

M.steam_app = {
    cmd = { "steam" },
    class = "^steam_app",
}

M.tutanota = {
    cmd = { "/opt/tutanota-desktop/tutanota-desktop" },
    class = "^tutanota",
}

M.terminal = M.wezterm
M.browser = M.librewolf
M.current_game = M.steam_app
M.mail = M.tutanota

return M
