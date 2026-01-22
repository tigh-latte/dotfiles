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

M.terminal = M.wezterm
M.browser = M.librewolf

return M
