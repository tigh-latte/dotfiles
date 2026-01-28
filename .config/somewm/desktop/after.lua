local awful = require("awful")
local naughty = require("naughty")

screen.primary.scale = 1

-- Check for update on boot. If yes, notify.
awful.spawn.easy_async_with_shell(
    "cd ~/Dev/github.com/trip-zip/somewm && git fetch upstream && git rev-list HEAD..upstream/main --count",
    function(stdout, _, _, exitcode)
        if exitcode ~= 0 then return end
        local commits_behind = tonumber(stdout)
        if commits_behind == 0 then return end

        naughty.notify {
            title = "New update for SomeWM",
            text = "Pull and install",
            timeout = 10,
            position = "top_middle",
            width = 500,
        }
    end)
