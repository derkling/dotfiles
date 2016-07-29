
--{{{ Applications
terminal   = os.getenv("TERMINAL") or "x-terminal-emulator"
editor     = os.getenv("EDITOR")   or "vim"
editor_cmd = terminal .. " -e " .. editor
browser    = os.getenv("BROWSER")  or "chromium-browser"
filemanager = "thunar"
mail       = terminal .. " -e mutt "
musicplr   = terminal .. " -g l30x34-320+16 -e pms "
gui_editor = "gedit"
graphics   = "gimp"
settings   = "unity-control-center"
screenshot = "xfce4-screenshooter"
calculator = "gnome-calculator"
telegram   = "/opt/Telegram/Telegram -noupdate"

--{{{ Language
language = string.gsub(os.getenv("LANG"), ".utf8", "")

--{{{ Modkeys
modkey = "Mod4"
altkey = "Mod1"

--{{{ Layouts
-- local layouts = {
layouts = {
    awful.layout.suit.floating,
    lain.layout.uselesstile,
    awful.layout.suit.fair,
    lain.layout.uselesstile.left,
    lain.layout.uselesstile.top
}

-- {{{ Tags
tags = {
   names = { " MAIN ", " WEB ", " MAIL ", " SOCIAL ", " MEDIA " },
   layout = { layouts[2], layouts[2], layouts[2], layouts[2] , layouts[2]}
}
for s = 1, screen.count() do
   tags[s] = awful.tag(tags.names, s, tags.layout)
end

