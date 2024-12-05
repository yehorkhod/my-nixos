-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-------------------------------- ERROR HANDLING --------------------------------
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end

-------------------------------- VARAIBLE DEFINITIONS  --------------------------------
beautiful.init("/home/yehorkhod/.config/awesome/theme.lua")

terminal = "kitty"
editor = "nvim"
browser = "zen"
messanger = "telegram-desktop"
editor_cmd = terminal .. " -e " .. editor

modkey = "Mod4"

awful.layout.layouts = {
    awful.layout.suit.spiral.dwindle,
}

awful.spawn.with_shell("setxkbmap -layout us,ua -option grp:win_space_toggle")

-------------------------------- MENU  --------------------------------
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

mymainmenu = awful.menu({
    items = {
        { "awesome", myawesomemenu },
        { "open terminal", terminal }
    }
})

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-------------------------------- WIBAR  --------------------------------
-- Battery widget
local battery_widget = wibox.widget {
    widget = wibox.widget.textbox,
    align = "center",
    valign = "center"
}

local function update_battery()
    awful.spawn.easy_async_with_shell("cat /sys/class/power_supply/BAT1/capacity && cat /sys/class/power_supply/BAT1/status", function(out)
        local battery_level, status = out:match("(%d+)%s+(%a+)")
        battery_level = tonumber(battery_level) or 0

        local icon = (status == "Charging") and "⚡" or "🔋"
        battery_widget.markup = string.format("%s %d%%", icon, battery_level)
    end)
end

-- Update the widget periodically
gears.timer {
    timeout = 30, -- Update every 30 seconds
    call_now = true,
    autostart = true,
    callback = update_battery
}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- Create a textclock widget
mytextclock = wibox.widget.textclock()

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey, }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey, }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

local tasklist_buttons = gears.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  c:emit_signal(
                                                      "request::activate",
                                                      "tasklist",
                                                      {raise = true}
                                                  )
                                              end
                                          end),
                     awful.button({ }, 3, function()
                                              awful.menu.client_list({ theme = { width = 250 } })
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons
    }

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            battery_widget,
            mykeyboardlayout,
            wibox.widget.systray(),
            mytextclock,
        },
    }
end)

-------------------------------- MOUSE BINDINGS  --------------------------------
root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))

-------------------------------- KEY BINDINGS  --------------------------------
globalkeys = gears.table.join(
    -- Volume
    awful.key(
        { },
        "XF86AudioRaiseVolume",
        function ()
            awful.spawn.with_shell([[
            pamixer -i 10 && notify-send -t 1000 "Volume is set to $(pamixer --get-volume-human)"
            ]])
        end,
        { description = "Increase Volume", group = "volume" }
    ),
    awful.key(
        { },
        "XF86AudioLowerVolume",
        function ()
            awful.spawn.with_shell([[
            pamixer -d 10 && notify-send -t 1000 "Volume is set to $(pamixer --get-volume-human)"
            ]])
        end,
        { description = "Dencrease Volume", group = "volume" }
    ),
    awful.key(
        { },
        "XF86AudioMute",
        function ()
            awful.spawn.with_shell([[
            pamixer -t && notify-send -t 1000 "Volume is set to $(pamixer --get-volume-human)"
            ]])
        end,
        { description = "Volume Mute", group = "volume" }
    ),

    -- Brightness
    awful.key(
        { },
        "XF86MonBrightnessUp",
        function ()
            awful.spawn.with_shell([[
            brightnessctl s 10%+ && notify-send -t 1000 "Brightness is set to $(brightnessctl i | grep -oP '\(\K[0-9]+(?=%\))')%"
            ]])
        end,
        { description = "Increase Brightness", group = "brightness" }
    ),
    awful.key(
        { },
        "XF86MonBrightnessDown",
        function ()
            awful.spawn.with_shell([[
            brightnessctl s 10%- && notify-send -t 1000 "Brightness is set to $(brightnessctl i | grep -oP '\(\K[0-9]+(?=%\))')%"
            ]])
        end,
        { description = "Dencrease Brightness", group = "brightness" }
    ),

    -- Screenshot
    awful.key(
        { modkey, "Shift" }, 
        "s", 
        function() 
            awful.spawn.with_shell("shotgun -g $(hacksaw) /tmp/image.png && xclip -selection clipboard -t image/png -i /tmp/image.png")
        end,
        { description = "take selection screenshot", group = "screenshot" }
    ),
    awful.key(
        {}, 
        "Print", 
        function() 
            awful.spawn.with_shell("shotgun /tmp/image.png && xclip -selection clipboard -t image/png -i /tmp/image.png")
        end,
        { description = "take full screenshot", group = "screenshot" }
    ),

    -- Move focus
    awful.key(
        { modkey, },
        "Left", 
        awful.tag.viewprev,
        { description = "view previous", group = "tag" }
    ),
    awful.key(
        { modkey, },
        "Right",
        awful.tag.viewnext,
        { description = "view next", group = "tag" }
    ),

    awful.key(
        { modkey, },
        "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        { description = "focus next by index", group = "client" }
    ),
    awful.key(
        { modkey, },
        "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        { description = "focus previous by index", group = "client" }
    ),
    awful.key(
        { modkey, },
        "w",
        function () mymainmenu:show() end,
        { description = "show main menu", group = "awesome" }
    ),

    -- Layout manipulation
    awful.key(
        { modkey, "Shift" },
        "j",
        function () awful.client.swap.byidx(1)    end,
        { description = "swap with next client by index", group = "client" }
    ),
    awful.key(
        { modkey, "Shift" },
        "k",
        function () awful.client.swap.byidx(-1)    end,
        { description = "swap with previous client by index", group = "client" }
    ),
    awful.key(
        { modkey, },
        "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        { description = "go back", group = "client" }
    ),

    -- Programs
    awful.key(
        { modkey, },
        "Return",
        function () awful.spawn(terminal) end,
        { description = "open a terminal", group = "launcher" }
    ),
    awful.key(
        { modkey, },
        "f",
        function () awful.spawn(browser) end,
        { description = "open a browser", group = "launcher" }
    ),
    awful.key(
        { modkey, },
        "t",
        function () awful.spawn(messanger) end,
        { description = "open a messanger", group = "launcher" }
    ),
    awful.key(
        { modkey, },
        "d",
        function () menubar.show() end,
        { description = "show the menubar", group = "launcher" }
    ),

    awful.key(
        { modkey, "Control" },
        "r",
        awesome.restart,
        { description = "reload awesome", group = "awesome" }
    ),
    awful.key(
        { modkey, "Shift" },
        "q",
        awesome.quit,
        { description = "quit awesome", group = "awesome" }
    ),

    awful.key(
        { modkey, },
        "l",
        function () awful.tag.incmwfact(0.05) end,
        { description = "increase master width factor", group = "layout" }
    ),
    awful.key(
        { modkey, },
        "h",
        function () awful.tag.incmwfact(-0.05) end,
        { description = "decrease master width factor", group = "layout" }
    ),
    awful.key(
        { modkey, "Shift" },
        "h",
        function () awful.tag.incnmaster(1, nil, true) end,
        { description = "increase the number of master clients", group = "layout" }
    ),
    awful.key(
        { modkey, "Shift" },
        "l",
        function () awful.tag.incnmaster(-1, nil, true) end,
        { description = "decrease the number of master clients", group = "layout" }
    )
)

clientkeys = gears.table.join(
    awful.key(
        { modkey, },
        "i",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        { description = "toggle fullscreen", group = "client" }
    ),
    awful.key(
        { modkey, },
        "c",
        function (c) c:kill() end,
        { description = "close", group = "client" }
    )
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key(
            { modkey, },
            "#" .. i + 9,
            function ()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    tag:view_only()
                end
            end,
            { description = "view tag #" .. i, group = "tag" }
        ),

        -- Toggle tag display.
        awful.key(
            { modkey, "Control" },
            "#" .. i + 9,
            function ()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end,
            { description = "toggle tag #" .. i, group = "tag" }
        ),

        -- Move client to tag.
        awful.key(
            { modkey, "Shift" },
            "#" .. i + 9,
            function ()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end,
            { description = "move focused client to tag #" .. i, group = "tag" }
        )
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey, }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey, }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)

-------------------------------- RULES  --------------------------------
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
          "pinentry",
        },
        class = {
          "Arandr",
          "Blueman-manager",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
          "Wpa_gui",
          "veromix",
          "xtightvncviewer"},

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager",  -- Thunderbird's about:config.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},
}

-------------------------------- SYGNALS  --------------------------------
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
