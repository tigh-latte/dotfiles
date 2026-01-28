local awful = require("awful")
local beautiful = require("beautiful")

beautiful.wallpaper = os.getenv("HOME") .. "/Pictures/Wallpapers/forest.png"

awful.spawn.with_shell("wlr-randr --output DP-2 --mode 2560x1440@144.006Hz")
