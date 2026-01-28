local beautiful = require("beautiful")
local awful = require("awful")

beautiful.wallpaper = os.getenv("HOME") .. "/Pictures/Wallpapers/river.jpg"

awful.input.tap_to_click = 1
awful.input.natural_scrolling = 1

awful.spawn.with_shell("wlr-randr --output eDP-1 --mode 2880x1920@60.000999")
