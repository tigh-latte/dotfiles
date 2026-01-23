-- awesome_mode: api-level=4:screen=on
-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

-- Widgets/bars
local wibox = require("wibox")

-- Themes
local beautiful = require("beautiful")

-- Notifications
local naughty = require("naughty")

-- Per app/notification rules
local ruled = require("ruled")

-- App select-esq menu
local menubar = require("menubar")

local hotkeys_popup = require("awful.hotkeys_popup")

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- the ol keyboard
awful.input.xkb_layout = "gb"
awful.input.xkb_variant = "extd"

awful.input.keyboard_repeat_rate = 35
awful.input.keyboard_repeat_delay = 450


-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
naughty.connect_signal("request::display_error", function(message, startup)
    naughty.notification {
        urgency = "critical",
        title   = "Oops, an error happened" .. (startup and " during startup!" or "!"),
        message = message,
    }
end)

-- Show notification if we fell back due to X11-specific patterns in user config
if awesome.x11_fallback_info then
    -- Defer notification until after startup (naughty needs event loop running)
    gears.timer.delayed_call(function()
        local info = awesome.x11_fallback_info
        local msg = string.format(
            "Your config was skipped because it contains X11-specific code that " ..
            "won't work on Wayland.\n\n" ..
            "File: %s:%d\n" ..
            "Pattern: %s\n" ..
            "Code: %s\n\n" ..
            "Suggestion: %s\n\n" ..
            "Edit your rc.lua to remove X11 dependencies, then restart somewm.",
            info.config_path or "unknown",
            info.line_number or 0,
            info.pattern or "unknown",
            info.line_content or "",
            info.suggestion or "See somewm migration guide"
        )
        naughty.notification {
            urgency = "critical",
            title   = "Config contains X11 patterns - using fallback",
            message = msg,
            timeout = 0, -- Don't auto-dismiss
        }
    end)
end

-- Set and init theme.
local theme = dofile(gears.filesystem.get_themes_dir() .. "default/theme.lua")
beautiful.init(theme)

-- Get machine name for device specific config
local hostname = (function()
    local f = io.open("/etc/hostname")
    if not f then return "" end
    local hname = f:read("*l")
    f:close()
    return hname
end)()

-- before hook.
pcall(require, hostname .. ".before")

-- Common program helpers
local programs = require("programs")

local terminal = programs.terminal.cmd[1]
local editor = os.getenv("EDITOR") or "nvim"
local editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
_G.modkey = "Mod4"
local altkey = "Mod1"
-- }}}

-- {{{ Menu
-- @DOC_MENU@
-- Create a launcher widget and a main menu
local myawesomemenu = {
    { "hotkeys",     function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
    { "manual",      terminal .. " -e man awesome" },
    { "edit config", editor_cmd .. " " .. awesome.conffile },
    { "restart",     awesome.restart },
    { "quit",        function() awesome.quit() end },
}

local mymainmenu = awful.menu({
    items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
        { "open terminal", terminal },
    },
})

local mylauncher = awful.widget.launcher({
    image = beautiful.awesome_icon,
    menu = mymainmenu,
})

menubar.utils.terminal = terminal -- Set the terminal for applications that require it

tag.connect_signal("request::default_layouts", function()
    -- Layout options
    awful.layout.append_default_layouts({
        awful.layout.suit.floating,
        -- awful.layout.suit.tile,
        -- awful.layout.suit.tile.left,
        -- awful.layout.suit.tile.bottom,
        -- awful.layout.suit.tile.top,
        -- awful.layout.suit.fair,
        -- awful.layout.suit.fair.horizontal,
        -- awful.layout.suit.spiral,
        -- awful.layout.suit.spiral.dwindle,
        -- awful.layout.suit.max,
        -- awful.layout.suit.max.fullscreen,
        -- awful.layout.suit.magnifier,
        -- awful.layout.suit.corner.nw,
    })
end)

screen.connect_signal("request::wallpaper", function(s)
    gears.wallpaper.maximized(beautiful.wallpaper, s)
end)

-- Keyboard map indicator and switcher
local mykeyboardlayout = awful.widget.keyboardlayout()


-- Create a textclock widget
local mytextclock = wibox.widget.textclock()

-- On each screen connecting, do:
screen.connect_signal("request::desktop_decoration", function(s)
    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()

    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    -- s.mylayoutbox = awful.widget.layoutbox {
    --     screen  = s,
    --     buttons = {
    --         awful.button({}, 1, function() awful.layout.inc(1) end),
    --         awful.button({}, 3, function() awful.layout.inc(-1) end),
    --         awful.button({}, 4, function() awful.layout.inc(-1) end),
    --         awful.button({}, 5, function() awful.layout.inc(1) end),
    --     },
    -- }

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = {
            awful.button({}, 1, function(t) t:view_only() end),
            awful.button({ modkey }, 1, function(t)
                if client.focus then
                    client.focus:move_to_tag(t)
                end
            end),
            awful.button({}, 3, awful.tag.viewtoggle),
            awful.button({ modkey }, 3, function(t)
                if client.focus then
                    client.focus:toggle_tag(t)
                end
            end),
            awful.button({}, 4, function(t) awful.tag.viewprev(t.screen) end),
            awful.button({}, 5, function(t) awful.tag.viewnext(t.screen) end),
        },
    }

    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = {
            awful.button({}, 1, function(c)
                c:activate { context = "tasklist", action = "toggle_minimization" }
            end),
            awful.button({}, 3, function() awful.menu.client_list { theme = { width = 250 } } end),
            awful.button({}, 4, function() awful.client.focus.byidx(-1) end),
            awful.button({}, 5, function() awful.client.focus.byidx(1) end),
        },
    }

    s.mywibox = awful.wibar {
        position     = "top",
        screen       = s,
        -- @DOC_SETUP_WIDGETS@
        bg           = beautiful.bg_normal .. "cc",
        border_width = 1,
        border_color = beautiful.border_color_normal,
        widget       = {
            layout = wibox.layout.align.horizontal,
            { -- Left widgets
                layout = wibox.layout.fixed.horizontal,
                mylauncher,
                s.mytaglist,
                s.mypromptbox,
            },
            s.mytasklist, -- Middle widget
            {             -- Right widgets
                layout = wibox.layout.fixed.horizontal,
                mykeyboardlayout,
                wibox.widget.systray(),
                mytextclock,
                -- s.mylayoutbox,
            },
        },
        visible      = false,
    }

    local function show_wibar()
        if s.mywibox.visible then return end
        s.mywibox.visible = mouse.coords().y <= 5
    end

    s.show_wibar_timer = gears.timer {
        timeout = 0.15,
        callback = show_wibar,
        autostart = true,
    }

    s.mywibox:connect_signal("property::visible", function()
        (s.mywibox.visible and s.show_wibar_timer.stop or s.show_wibar_timer.start)(s.show_wibar_timer)
    end)
    s.mywibox:connect_signal("mouse::leave", function()
        s.mywibox.visible = false
    end)
end)

-- Desktop level mouse bindings.
awful.mouse.append_global_mousebindings({
    awful.button({}, 3, function() mymainmenu:toggle() end),
    awful.button({}, 4, awful.tag.viewprev),
    awful.button({}, 5, awful.tag.viewnext),
})


-- General Awesome keys
awful.keyboard.append_global_keybindings({
    awful.key({ modkey }, "s", hotkeys_popup.show_help,
        { description = "show help", group = "awesome" }),
    awful.key({ modkey }, "Enter", function() mymainmenu:show() end,
        { description = "show main menu", group = "awesome" }),
    awful.key({ modkey, "Shift" }, "r", awesome.restart,
        { description = "reload awesome", group = "awesome" }),
    awful.key({ modkey, "Shift" }, "q", awesome.quit,
        { description = "quit awesome", group = "awesome" }),
    awful.key({ modkey }, "x",
        function()
            awful.prompt.run {
                prompt       = "Run Lua code: ",
                textbox      = awful.screen.focused().mypromptbox.widget,
                exe_callback = awful.util.eval,
                history_path = awful.util.get_cache_dir() .. "/history_eval",
            }
        end,
        { description = "lua execute prompt", group = "awesome" }),
    awful.key({ altkey }, "space", function() awful.spawn({ "rofi", "-show", "drun", "-show-icons" }) end,
        { description = "spotlight", group = "launcher" }),
    awful.key({ modkey }, "r", function() awful.screen.focused().mypromptbox:run() end,
        { description = "run prompt", group = "launcher" }),
    awful.key({ modkey }, "p", function() menubar.show() end,
        { description = "show the menubar", group = "launcher" }),
    awful.key({ modkey }, "b", function()
        local s = awful.screen.focused()
        s.mywibox.visible = not s.mywibox.visible
    end, { description = "toggle wibar", group = "client" }),
})

-- The Main Characters
---@param program tigh-latte.some.Program
local function spawn_or_focus(program)
    return function()
        local client_is_program = function(c) return c and c.class and c.class:lower():find(program.class:lower()) end

        local matching = function()
            local cc = {}
            for c in awful.client.iterate(client_is_program) do
                table.insert(cc, c)
            end
            table.sort(cc, function(a, b) return a.id < b.id end)

            return cc
        end

        local target = (function()
            -- If focused on program, cycle through windows in order of being opened.
            if client_is_program(client.focus) then
                local cc = matching()
                for i, c in ipairs(cc) do
                    if c.id == client.focus.id then
                        local next = cc[i % #cc + 1]
                        return next
                    end
                end
            end

            -- If program isn't in focus,  search focus history, to focus on previously viewed window.
            local last_focused = awful.client.focus.history.get(0, nil, client_is_program)
            if last_focused then return last_focused end

            -- find any running instance of the program
            for _, c in awful.client.iterate(client_is_program) do
                return c
            end
        end)()
        if target then -- if target found
            target:jump_to(false)
        else           -- otherwise, spawn
            awful.spawn(program.cmd)
        end
    end
end

awful.keyboard.append_global_keybindings {
    awful.key({ modkey }, "d", spawn_or_focus(programs.terminal), { description = "open a terminal", group = "launcher" }),
    awful.key({ modkey }, "f", spawn_or_focus(programs.browser), { description = "open a browser", group = "launcher" }),
    awful.key({ modkey }, "c", spawn_or_focus(programs.signal), { description = "open chat", group = "launcher" }),
    awful.key({ modkey }, "w", spawn_or_focus(programs.slack), { description = "open work chat", group = "launcher" }),
}

-- Tags related keybindings
awful.keyboard.append_global_keybindings({
    awful.key({ modkey }, "Left", awful.tag.viewprev,
        { description = "view previous", group = "tag" }),
    awful.key({ modkey }, "Right", awful.tag.viewnext,
        { description = "view next", group = "tag" }),
    awful.key({ modkey }, "Escape", awful.tag.history.restore,
        { description = "go back", group = "tag" }),
})


-- Focus related keybindings
awful.keyboard.append_global_keybindings({
    awful.key({ modkey }, "j",
        function()
            awful.client.focus.byidx(1)
        end,
        { description = "focus next by index", group = "client" }
    ),
    awful.key({ modkey }, "k",
        function()
            awful.client.focus.byidx(-1)
        end,
        { description = "focus previous by index", group = "client" }
    ),
    awful.key({ modkey }, "Tab",
        function()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        { description = "go back", group = "client" }),
    awful.key({ modkey, "Control" }, "j", function() awful.screen.focus_relative(1) end,
        { description = "focus the next screen", group = "screen" }),
    awful.key({ modkey, "Control" }, "k", function() awful.screen.focus_relative(-1) end,
        { description = "focus the previous screen", group = "screen" }),
    awful.key({ modkey, "Control" }, "n",
        function()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
                c:activate { raise = true, context = "key.unminimize" }
            end
        end,
        { description = "restore minimized", group = "client" }),
})

-- Media keys on keyboard
awful.spawn.once("swayosd-server") -- start volume and brightness UI.
awful.keyboard.append_global_keybindings({
    -- Audio controls
    awful.key({}, "XF86AudioMute", function()
        awful.spawn({ "swayosd-client", "--output-volume", "mute-toggle" })
    end, { description = "(un)mute volume", group = "media" }),
    awful.key({}, "XF86AudioLowerVolume", function()
        awful.spawn({ "swayosd-client", "--output-volume", "lower" })
    end, { description = "lower volume", group = "media" }),
    awful.key({}, "XF86AudioRaiseVolume", function()
        awful.spawn({ "swayosd-client", "--output-volume", "raise" })
    end, { description = "raise volume", group = "media" }),

    -- Brightness controls
    awful.key({}, "XF86MonBrightnessDown", function()
        awful.spawn({ "swayosd-client", "--brightness", "lower" })
    end, { description = "lower brightness", group = "media" }),
    awful.key({}, "XF86MonBrightnessUp", function()
        awful.spawn({ "swayosd-client", "--brightness", "raise" })
    end, { description = "raise brightness", group = "media" }),

    -- Media Controls
    awful.key({}, "XF86AudioPlay", function()
        awful.spawn({ "playerctl", "play-pause" })
    end, { description = "(un)pause media", group = "media" }),
    awful.key({}, "XF86AudioNext", function()
        awful.spawn({ "playerctl", "next" })
    end, { description = "next media", group = "media" }),
    awful.key({}, "XF86AudioPrev", function()
        awful.spawn({ "playerctl", "prev" })
    end, { description = "prev media", group = "media" }),

    -- Print Screen
    awful.key({}, "Print", function()
        awful.spawn.with_shell('grim -g "$(slurp)" - | wl-copy')
    end, { description = "capture region of screen to clipboard", group = "screenshot" }),
})

-- Layout related keybindings
awful.keyboard.append_global_keybindings({
    awful.key({ modkey, "Shift" }, "j", function() awful.client.swap.byidx(1) end,
        { description = "swap with next client by index", group = "client" }),
    awful.key({ modkey, "Shift" }, "k", function() awful.client.swap.byidx(-1) end,
        { description = "swap with previous client by index", group = "client" }),
    awful.key({ modkey }, "u", awful.client.urgent.jumpto,
        { description = "jump to urgent client", group = "client" }),
    awful.key({ modkey }, "l", function() awful.tag.incmwfact(0.05) end,
        { description = "increase master width factor", group = "layout" }),
    awful.key({ modkey }, "h", function() awful.tag.incmwfact(-0.05) end,
        { description = "decrease master width factor", group = "layout" }),
    awful.key({ modkey, "Shift" }, "h", function() awful.tag.incnmaster(1, nil, true) end,
        { description = "increase the number of master clients", group = "layout" }),
    awful.key({ modkey, "Shift" }, "l", function() awful.tag.incnmaster(-1, nil, true) end,
        { description = "decrease the number of master clients", group = "layout" }),
    awful.key({ modkey, "Control" }, "h", function() awful.tag.incncol(1, nil, true) end,
        { description = "increase the number of columns", group = "layout" }),
    awful.key({ modkey, "Control" }, "l", function() awful.tag.incncol(-1, nil, true) end,
        { description = "decrease the number of columns", group = "layout" }),
    awful.key({ modkey }, "space", function() awful.layout.inc(1) end,
        { description = "select next", group = "layout" }),
    awful.key({ modkey, "Shift" }, "space", function() awful.layout.inc(-1) end,
        { description = "select previous", group = "layout" }),
})

awful.keyboard.append_global_keybindings({
    awful.key {
        -- Move to tag assigned by number
        modifiers   = { modkey },
        keygroup    = "numrow",
        description = "only view tag",
        group       = "tag",
        on_press    = function(index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                tag:view_only()
            end
        end,
    },
    awful.key {
        -- Toggle also showing tag assigned by number
        modifiers   = { modkey, "Control" },
        keygroup    = "numrow",
        description = "toggle tag",
        group       = "tag",
        on_press    = function(index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                awful.tag.viewtoggle(tag)
            end
        end,
    },

    awful.key {
        -- Move current application to tag assigned by number
        modifiers   = { modkey, "Shift" },
        keygroup    = "numrow",
        description = "move focused client to tag",
        group       = "tag",
        on_press    = function(index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:move_to_tag(tag)
                end
            end
        end,
    },
    awful.key {
        -- Toggle current application to also show in tag assigned by number
        modifiers   = { modkey, "Control", "Shift" },
        keygroup    = "numrow",
        description = "toggle focused client on tag",
        group       = "tag",
        on_press    = function(index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:toggle_tag(tag)
                end
            end
        end,
    },
    awful.key {
        -- Select layout.
        modifiers   = { modkey },
        keygroup    = "numpad",
        description = "select layout directly",
        group       = "layout",
        on_press    = function(index)
            local t = awful.screen.focused().selected_tag
            if t then
                t.layout = t.layouts[index] or t.layout
            end
        end,
    },
})

-- Client level mouse bindings.
client.connect_signal("request::default_mousebindings", function()
    awful.mouse.append_client_mousebindings({
        awful.button({}, 1, function(c)
            c:activate { context = "mouse_click" }
        end),
        awful.button({ modkey }, 1, function(c)
            c:activate { context = "mouse_click", action = "mouse_move" }
        end),
        awful.button({ modkey }, 3, function(c)
            c:activate { context = "mouse_click", action = "mouse_resize" }
        end),
    })
end)

-- Client level key bindings.
client.connect_signal("request::default_keybindings", function()
    -- Rectangles style window management
    local rectangles = function(pos, ratio)
        return function()
            local c = client.focus
            local w = mouse.screen.geometry.width * ratio
            c:geometry({ width = w - 1, height = mouse.screen.geometry.height - 10 })
            local f = awful.placement[pos] --+ awful.placement.maximized_vertically
            f(c, { honor_workarea = true })
            c:geometry({ y = 5 })
        end
    end

    awful.keyboard.append_client_keybindings({
        awful.key({ modkey, "Shift" }, "f",
            function(c)
                c.fullscreen = not c.fullscreen
                c:raise()
            end,
            { description = "toggle fullscreen", group = "client" }),
        awful.key({ modkey, "Control" }, "q", function(c) c:kill() end,
            { description = "close", group = "client" }),
        awful.key({ altkey }, "F4", function(c) c:kill() end,
            { description = "close", group = "client" }),
        awful.key({ modkey, "Control" }, "space", awful.client.floating.toggle,
            { description = "toggle floating", group = "client" }),
        awful.key({ modkey, "Control" }, "Return", function(c) c:swap(awful.client.getmaster()) end,
            { description = "move to master", group = "client" }),
        awful.key({ modkey }, "o", function(c) c:move_to_screen() end,
            { description = "move to screen", group = "client" }),
        awful.key({ modkey }, "t", function(c) c.ontop = not c.ontop end,
            { description = "toggle keep on top", group = "client" }),
        awful.key({ modkey }, "n",
            function(c)
                -- The client currently has the input focus, so it cannot be
                -- minimized, since minimized clients can't have the focus.
                c.minimized = true
            end,
            { description = "minimize", group = "client" }),
        awful.key({ modkey }, "m",
            function(c)
                c.maximized = not c.maximized
                c:raise()
            end,
            { description = "(un)maximize", group = "client" }),
        awful.key({ modkey, "Control" }, "m",
            function(c)
                c.maximized_vertical = not c.maximized_vertical
                c:raise()
            end,
            { description = "(un)maximize vertically", group = "client" }),
        awful.key({ modkey, "Shift" }, "m",
            function(c)
                c.maximized_horizontal = not c.maximized_horizontal
                c:raise()
            end,
            { description = "(un)maximize horizontally", group = "client" }),
        awful.key({ modkey, "Control" }, "w", rectangles("left", 2 / 3),
            { description = "two thirds left", group = "rectangles" }),
        awful.key({ modkey, "Control" }, "e", rectangles("centered", 2 / 3),
            { description = "two thirds centred", group = "rectangles" }),
        awful.key({ modkey, "Control" }, "r", rectangles("right", 2 / 3),
            { description = "two thirds right", group = "rectangles" }),

        awful.key({ modkey, "Control" }, "s", rectangles("left", 1 / 3),
            { description = "one thirds left", group = "rectangles" }),
        awful.key({ modkey, "Control" }, "d", rectangles("centered", 1 / 3),
            { description = "one thirds centred", group = "rectangles" }),
        awful.key({ modkey, "Control" }, "f", rectangles("right", 1 / 3),
            { description = "one thirds right", group = "rectangles" }),
    })
end)

-- Rules to apply to new clients.
ruled.client.connect_signal("request::rules", function()
    -- All clients will match this rule.
    ruled.client.append_rule {
        id         = "global",
        rule       = {},
        properties = {
            focus  = awful.client.focus.filter,
            raise  = true,
            screen = awful.screen.preferred,
            -- placement = awful.placement.no_offscreen,
        },
    }

    -- Floating clients.
    ruled.client.append_rule {
        id         = "floating",
        rule_any   = {
            instance = { "copyq", "pinentry" },
            class    = {
                "Arandr", "Blueman-manager", "Gpick", "Kruler", "Sxiv",
                "Tor Browser", "Wpa_gui", "veromix", "xtightvncviewer",
            },
            -- Note that the name property shown in xprop might be set slightly after creation of the client
            -- and the name shown there might not match defined rules here.
            name     = {
                "Event Tester", -- xev.
            },
            role     = {
                "AlarmWindow",   -- Thunderbird's calendar.
                "ConfigManager", -- Thunderbird's about:config.
                "pop-up",        -- e.g. Google Chrome's (detached) Developer Tools.
            },
        },
        properties = { floating = true },
    }

    -- Add titlebars to normal clients and dialogs
    ruled.client.append_rule {
        id         = "titlebars",
        rule_any   = { type = { "normal", "dialog" } },
        properties = { titlebars_enabled = false },
    }


    -- TODO: init via callback for ideal placement
    ruled.client.append_rule {
        rule_any = { class = { "wezterm", "librewolf" } },
        placement = function(d, arg)
            if #mouse.screen.selected_tag:clients() == 0 then
                awful.placement.centered(d, arg)
                return
            else
                awful.placement.left(d, arg)
            end
        end,
        properties = {
            height = mouse.screen.geometry.height - 2,
            width = mouse.screen.geometry.width / 3 * 2,
        },
    }

    -- TODO: init via callback for ideal placement
    ruled.client.append_rule {
        rule = { class = "signal" },
        placement = awful.placement.right,
        properties = {
            height = mouse.screen.geometry.height - 2,
            width = mouse.screen.geometry.width / 3,
        },
    }

    ruled.client.append_rule {
        rule = { class = "^steam$" },
        properties = {
            tag = "2",
            x = 5,
            y = 5,
            height = mouse.screen.geometry.height - 10,
            width = mouse.screen.geometry.width - 10,
        },
    }

    ruled.client.append_rule {
        rule = { class = "^steam_app" },
        properties = {
            tag = "3",
        },
    }

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- ruled.client.append_rule {
    --     rule       = { class = "Firefox"     },
    --     properties = { screen = 1, tag = "2" }
    -- }
end)
-- }}}

-- Titlebar rules (Turned off as I don't like them)
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    -- local buttons = {
    --     awful.button({}, 1, function()
    --         c:activate { context = "titlebar", action = "mouse_move" }
    --     end),
    --     awful.button({}, 3, function()
    --         c:activate { context = "titlebar", action = "mouse_resize" }
    --     end),
    -- }

    -- awful.titlebar(c).widget = {
    --     { -- Left
    --         awful.titlebar.widget.iconwidget(c),
    --         buttons = buttons,
    --         layout  = wibox.layout.fixed.horizontal,
    --     },
    --     {     -- Middle
    --         { -- Title
    --             halign = "center",
    --             widget = awful.titlebar.widget.titlewidget(c),
    --         },
    --         buttons = buttons,
    --         layout  = wibox.layout.flex.horizontal,
    --     },
    --     { -- Right
    --         awful.titlebar.widget.floatingbutton(c),
    --         awful.titlebar.widget.maximizedbutton(c),
    --         awful.titlebar.widget.stickybutton(c),
    --         awful.titlebar.widget.ontopbutton(c),
    --         awful.titlebar.widget.closebutton(c),
    --         layout = wibox.layout.fixed.horizontal(),
    --     },
    --     layout = wibox.layout.align.horizontal,
    -- }
end)

-- Custom action when close a client
client.connect_signal("unmanage", function()
    -- if only one client left, move it to the centre
    local centre = function()
        local clients = mouse.screen.selected_tag:clients()
        local client = #clients == 1 and clients[1]
        if not client then return end
        if client.type == "dialog" then return end

        -- TODO: use rectangles function instead of placement.
        (awful.placement.centered + awful.placement.maximized_vertically)(clients[1])
    end

    -- on window close, auto focus on next window
    local focus = function()
        local prev_focus = awful.client.focus.history.get(nil, 0, function(c)
            return c ~= nil
        end)
        if prev_focus then prev_focus:jump_to(false) end
    end

    centre()
    focus()
end)

ruled.notification.connect_signal("request::rules", function()
    -- All notifications will match this rule.
    ruled.notification.append_rule {
        rule       = {},
        properties = {
            screen           = awful.screen.preferred,
            implicit_timeout = 5,
        },
    }
end)

naughty.connect_signal("request::display", function(n)
    naughty.layout.box { notification = n }
end)

-- give vars to systemd to allow for screensharing.
awful.spawn.once({
    "systemctl",
    "--user",
    "import-environment",
    "DISPLAY",
    "WAYLAND_DISPLAY",
    "XDG_CURRENT_DESKTOP",
})

awful.spawn.once({
    "dbus-update-activation-environment",
    "--systemd",
    "DISPLAY",
    "XDG_CURRENT_DESKTOP=somewm",
    "WAYLAND_DISPLAY",
})

pcall(require, hostname .. ".after")
