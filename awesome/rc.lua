
-- {{{ Required libraries
gears     = require("gears")
awful     = require("awful")
awful.rules     = require("awful.rules")
                  require("awful.autofocus")
wibox     = require("wibox")
beautiful = require("beautiful")
naughty   = require("naughty")
drop      = require("scratchdrop")
lain      = require("lain")

-- {{{ Error handling
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end

--{{{ Paths
home_dir   = os.getenv("HOME")
conf_dir   = home_dir .. "/dotfiles/awesome/"
theme_dir  = conf_dir .. "theme/"

--{{{ Configuration fragments
prefs_conf = conf_dir  .. "prefs.lua"
binds_conf = conf_dir  .. "binds.lua"
rules_conf = conf_dir  .. "rules.lua"
theme_conf = theme_dir .. "theme.lua"
wibox_conf = theme_dir .. "wibox.lua"

--{{{ User Preferences
dofile(prefs_conf)

--{{{ Theme
beautiful.init(theme_conf)

--{{{ Wibox
dofile(wibox_conf)

--{{{ XRandR Support
-- dofile(xrandr_conf)

--{{{ Keyboard and Mouse bindings
dofile(binds_conf)

--{{{ Appliation specific rules and signals
dofile(rules_conf)

-- Set keys
root.keys(globalkeys)
