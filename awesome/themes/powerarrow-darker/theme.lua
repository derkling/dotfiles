
--[[
                                             
     Powerarrow Darker Awesome WM config 2.0 
     github.com/copycat-killer               
                                             
--]]

-- {{{ Theme colors, images and fonts
theme                               = {}

theme.dir                           = os.getenv("HOME") .. "/dotfiles/awesome/themes/powerarrow-darker/"
theme.icon_dir                      = theme.dir .. "icons/"
theme.wallpaper                     = theme.dir .. "wall.png"

theme.font                          = "Terminus 9"
theme.fg_normal                     = "#DDDDFF"
theme.fg_focus                      = "#F0DFAF"
theme.fg_urgent                     = "#CC9393"
theme.bg_normal                     = "#1A1A1A"
theme.bg_focus                      = "#313131"
theme.bg_urgent                     = "#1A1A1A"
theme.border_width                  = "1"
theme.border_normal                 = "#3F3F3F"
theme.border_focus                  = "#7F7F7F"
theme.border_marked                 = "#CC9393"
theme.titlebar_bg_focus             = "#FFFFFF"
theme.titlebar_bg_normal            = "#FFFFFF"
theme.taglist_fg_focus              = "#D8D782"
theme.tasklist_bg_focus             = "#1A1A1A"
theme.tasklist_fg_focus             = "#D8D782"
theme.textbox_widget_margin_top     = 1
theme.notify_fg                     = theme.fg_normal
theme.notify_bg                     = theme.bg_normal
theme.notify_border                 = theme.border_focus
theme.awful_widget_height           = 14
theme.awful_widget_margin_top       = 2
theme.mouse_finder_color            = "#CC9393"
theme.menu_height                   = "16"
theme.menu_width                    = "140"

theme.submenu_icon                  = theme.icon_dir .. "submenu.png"
theme.taglist_squares_sel           = theme.icon_dir .. "square_sel.png"
theme.taglist_squares_unsel         = theme.icon_dir .. "square_unsel.png"

theme.layout_tile                   = theme.icon_dir .. "tile.png"
theme.layout_tilegaps               = theme.icon_dir .. "tilegaps.png"
theme.layout_tileleft               = theme.icon_dir .. "tileleft.png"
theme.layout_tilebottom             = theme.icon_dir .. "tilebottom.png"
theme.layout_tiletop                = theme.icon_dir .. "tiletop.png"
theme.layout_fairv                  = theme.icon_dir .. "fairv.png"
theme.layout_fairh                  = theme.icon_dir .. "fairh.png"
theme.layout_spiral                 = theme.icon_dir .. "spiral.png"
theme.layout_dwindle                = theme.icon_dir .. "dwindle.png"
theme.layout_max                    = theme.icon_dir .. "max.png"
theme.layout_fullscreen             = theme.icon_dir .. "fullscreen.png"
theme.layout_magnifier              = theme.icon_dir .. "magnifier.png"
theme.layout_floating               = theme.icon_dir .. "floating.png"

theme.arrl                          = theme.icon_dir .. "arrl.png"
theme.arrl_dl                       = theme.icon_dir .. "arrl_dl.png"
theme.arrl_ld                       = theme.icon_dir .. "arrl_ld.png"

theme.widget_ac                     = theme.icon_dir .. "ac.png"
theme.widget_battery                = theme.icon_dir .. "battery.png"
theme.widget_battery_low            = theme.icon_dir .. "battery_low.png"
theme.widget_battery_empty          = theme.icon_dir .. "battery_empty.png"
theme.widget_mem                    = theme.icon_dir .. "mem.png"
theme.widget_cpu                    = theme.icon_dir .. "cpu.png"
theme.widget_temp                   = theme.icon_dir .. "temp.png"
theme.widget_net                    = theme.icon_dir .. "net.png"
theme.widget_hdd                    = theme.icon_dir .. "hdd.png"
theme.widget_music                  = theme.icon_dir .. "note.png"
theme.widget_music_on               = theme.icon_dir .. "note_on.png"
theme.widget_vol                    = theme.icon_dir .. "vol.png"
theme.widget_vol_low                = theme.icon_dir .. "vol_low.png"
theme.widget_vol_no                 = theme.icon_dir .. "vol_no.png"
theme.widget_vol_mute               = theme.icon_dir .. "vol_mute.png"
theme.widget_mail                   = theme.icon_dir .. "mail.png"
theme.widget_mail_on                = theme.icon_dir .. "mail_on.png"

theme.tasklist_disable_icon         = true
theme.tasklist_floating             = ""
theme.tasklist_maximized_horizontal = ""
theme.tasklist_maximized_vertical   = ""

--}}}

return theme
