
-- The list of key bindings defined by this configuration can be obtained by
-- filtering this file using the following command:
-- $ tail -n +10 binds.lua | \
--       grep -e "  awful.key" -e KEY | \
--       sed -e 's/awful.key({ //' -e 's/}//' \
--           -e 's/"/ /g' \
--           -e 's/,/ /g' \
--           -e 's/-- KEY: /\n/' \
--           -e 's/^       /   /' \
--           -e 's/ .. i + 9//'

local read_pipe    = require("lain.helpers").read_pipe

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

globalkeys = awful.util.table.join(
   -- KEY: Tabs
    awful.key({ modkey            }, "Left",    -- Left non-empty tag
    	function () lain.util.tag_view_nonempty(-1) end),
    awful.key({ modkey            }, "Right",   -- Right non-empty tag
    	function () lain.util.tag_view_nonempty(1) end),
    awful.key({ modkey            }, "Escape",  -- Previous tab
    	awful.tag.history.restore ),
    awful.key({ modkey, "Control" }, "Left",    -- Left tab
    	awful.tag.viewprev ),
    awful.key({ modkey, "Control" }, "Right",   -- Rright tab
    	awful.tag.viewnext )

)


for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey            }, "#" .. i + 9,       -- View ONYL tag
                  function ()
                        local screen = mouse.screen
                        local tag = awful.tag.gettags(screen)[i]
                        if tag then
                           awful.tag.viewonly(tag)
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,       -- View ALSO tag
                  function ()
                      local screen = mouse.screen
                      local tag = awful.tag.gettags(screen)[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end))
end

globalkeys = awful.util.table.join(globalkeys,
    -- KEY: Clients
    -- awful.key({ altkey            }, "j",       -- Focus prev
    -- 	function ()
    --     	awful.client.focus.byidx(-1)
    --     	if client.focus then client.focus:raise() end
    -- 	end),
    -- awful.key({ modkey, "Control" }, "j",       -- Focus relative (prev)
    -- 	function () awful.screen.focus_relative(-1) end),
    -- awful.key({ altkey            }, "k",       -- Focus next
    --  	function ()
    --     	awful.client.focus.byidx( 1)
    --     	if client.focus then client.focus:raise() end
    --     end),
    -- awful.key({ modkey, "Control" }, "k",       -- Focus relative (next)
    -- 	function () awful.screen.focus_relative( 1) end),

    awful.key({ modkey            }, "h",       -- Focus left
    	function()
		awful.client.focus.bydirection("left")
		if client.focus then client.focus:raise() end
    	end),
    awful.key({ modkey            }, "j",       -- Focus down
    	function()
		awful.client.focus.bydirection("down")
		if client.focus then client.focus:raise() end
    	end),
    awful.key({ modkey            }, "k",       -- Focus up
    	function()
        	awful.client.focus.bydirection("up")
		if client.focus then client.focus:raise() end
	end),
    awful.key({ modkey            }, "l",       -- Focus right
    	function()
		awful.client.focus.bydirection("right")
		if client.focus then client.focus:raise() end
    	end),

    awful.key({ altkey, "Shift"   }, "j",       -- Swap with next
    	function () awful.client.swap.byidx(  1) end),
    awful.key({ altkey, "Shift"   }, "k",       -- Swap with prev
    	function () awful.client.swap.byidx( -1) end),

    awful.key({ altkey,           }, "u",       -- Focus urgent
    	awful.client.urgent.jumpto),
    awful.key({ altkey,           }, "Tab",     -- Focus previous
    	function ()
		awful.client.focus.history.previous()
		if client.focus then
		    client.focus:raise()
		end
	end),
    awful.key({ modkey,           }, "Tab",     -- Focus next screen
    	function ()
		awful.screen.focus_relative(1)
		if client.focus then
		    client.focus:raise()
		end
	end)
)

clientkeys = awful.util.table.join(

    awful.key({ modkey, "Shift"   }, "c",       -- Kill
    	function (c) c:kill() end),
    awful.key({ modkey,           }, "f",       -- Fullscreen
    	function (c) c.fullscreen = not c.fullscreen  end),


    awful.key({ modkey,           }, "m",       -- Maximize
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end),
    awful.key({ modkey,           }, "n",       -- Minimize
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey, "Control" }, "n",       -- Restore client
	awful.client.restore),


    awful.key({ modkey,           }, "o",       -- Toggle Screen
    	awful.client.movetoscreen                        ),
    awful.key({ modkey,           }, "t",       -- Toggle Top
    	function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey, "Control" }, "space",   -- Toggle floating
    	awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return",  -- Toggle master
    	function (c) c:swap(awful.client.getmaster()) end)

)

for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ altkey,           }, "#" .. i + 9,       -- View ONLY on tag
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.movetotag(tag)
                          end
                     end
                  end),
        awful.key({ altkey, "Control" }, "#" .. i + 9,       -- View ALSO on tag
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.toggletag(tag)
                          end
                      end
                  end)
    )
end


globalkeys = awful.util.table.join(globalkeys,

    -- KEY: Layout
    awful.key({ modkey,           }, "space",   -- Next layout
    	function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space",   -- Prev layout
    	function () awful.layout.inc(layouts, -1) end),

    awful.key({ modkey, "Control" }, "]",       -- Useless gaps change (increase)
    	function () lain.util.useless_gaps_resize(1) end),
    awful.key({ modkey, "Control" }, "[",       -- Useless gaps change (decrease)
    	function () lain.util.useless_gaps_resize(-1) end),

    awful.key({ modkey, "Shift"   }, "l",       -- Increase master window size
    	function () awful.tag.incmwfact( 0.05) end),
    awful.key({ modkey, "Shift"   }, "h",       -- Decrease master window size
    	function () awful.tag.incmwfact(-0.05) end),
    awful.key({ modkey, "Control" }, "l",       -- Decrease secondary columns
    	function () awful.tag.incncol(-1) end),
    awful.key({ modkey, "Control" }, "h",       -- Increase secondary columns
    	function () awful.tag.incncol( 1) end),


    -- KEY: Shortcuts
    awful.key({ },  "Print",                        -- Take a screenshot
    	function() os.execute("screenshot -w root") end),
    awful.key({ altkey            }, "b",       -- Show/Hide Wibox
	function ()
		mywibox[mouse.screen].visible = not mywibox[mouse.screen].visible
		mybottomwibox[mouse.screen].visible = not mybottomwibox[mouse.screen].visible
	end),
    awful.key({ altkey            }, "c",       -- Copy to clipboard
    	function () os.execute("xsel -p -o | xsel -i -b") end),
    awful.key({ altkey, "Control" }, "l",       -- Lock Screen
    	function ()
		awful.util.spawn("sync")
		awful.util.spawn("xautolock -locknow")
      	end),
    awful.key({ altkey, "Control" }, "q",       -- Quite Awesome
	awesome.quit),
    awful.key({ altkey, "Control" }, "r",       -- Restart Awesome
	awesome.restart),
    awful.key({ altkey, "Control" }, "s",       -- Suspend to RAM
    	function ()
		awful.util.spawn("sync")
		awful.util.spawn("xautolock -locknow")
		awful.util.spawn("systemctl suspend")
       	end),
    awful.key({ altkey            }, "r",       -- Prompt
    	function () mypromptbox[mouse.screen]:run() end),
    awful.key({ altkey            }, "x",       -- Lua code
    	function ()
		awful.prompt.run({ prompt = "Run Lua code: " },
			mypromptbox[mouse.screen].widget,
			awful.util.eval, nil,
			awful.util.getdir("cache") .. "/history_eval")
      	end),

    -- KEY: System Settings
    -- awful.key({ modkey, "Shift"   }, "l",       -- Decrease master windows
    -- 	function () awful.tag.incnmaster(-1) end),
    -- awful.key({ modkey, "Shift"   }, "h",       -- Increase master windows
    -- 	function () awful.tag.incnmaster( 1) end),
    awful.key({ },  "XF86MonBrightnessUp",          -- Backlight up
        function () os.execute("xbacklight -inc 10") end),
    awful.key({ },  "XF86MonBrightnessDown",        -- Backlight down
        function () os.execute("xbacklight -dec 10") end),

    awful.key({ },  "XF86AudioRaiseVolume",         -- Volume up
        function ()
        	os.execute(string.format("amixer set %s %s+", myvolumebar.channel, myvolumebar.step))
        	myvolumebar.update()
        end),
    awful.key({ },  "XF86AudioLowerVolume",         -- Volume down
        function ()
        	os.execute(string.format("amixer set %s %s-", myvolumebar.channel, myvolumebar.step))
        	myvolumebar.update()
        end),
    awful.key({ },  "XF86AudioMute",                -- Toggle Mute
        function ()
        	os.execute(string.format("amixer set %s toggle", myvolumebar.channel))
        	myvolumebar.update()
        end),

    -- KEY: User programs
    awful.key({ altkey,           }, "Return",  -- Terminal
    	function () awful.util.spawn(terminal) end),
    awful.key({ altkey,           }, "s",       -- Settings
    	function () awful.util.spawn(settings) end),
    awful.key({ altkey, "Shift"   }, "b",       -- Browser
    	function () awful.util.spawn(browser) end),
    awful.key({ altkey, "Shift"   }, "c",       -- Show Calculator
    	function () awful.util.spawn(calculator) end),
    awful.key({ altkey, "Shift"   }, "e",       -- Editor (GUI)
    	function () awful.util.spawn(gui_editor) end),
    awful.key({ altkey, "Shift"   }, "f",       -- Filemanager
    	function () awful.util.spawn(filemanager) end),
    awful.key({ altkey, "Shift"   }, "g",       -- Photo editor
    	function () awful.util.spawn(graphics) end),
    awful.key({ altkey, "Shift"   }, "m",       -- Mail
    	function () os.execute(mail) end),
    awful.key({ altkey, "Shift"   }, "s",       -- Screeshort
    	function () awful.util.spawn(screenshot) end),
    awful.key({ altkey, "Shift"   }, "t",       -- Telegram
    	function () awful.util.spawn(telegram) end),
    awful.key({ altkey, "Shift"   }, "w",       -- Show Weather
    	function () myweather.show(7) end)

)

    -- awful.key({ modkey            }, "m",       -- Show Menu
    -- function ()
    --     mymainmenu:show({ keygrabber = true })
    -- end),

    -- Dropdown terminal
    -- awful.key({ modkey            }, "z",
    -- function ()
	-- drop(terminal)
    -- end),

    -- XRandR Control
    -- awful.key({ modkey, "Control" }, "d",
    --     function()
    --         xrandr()
    --         naughty.notify({
    --     	title = string.format("Display select"),
    --     	text = "naughty", timeout = 0.5})
    --     end),

    -- MPD control
    -- awful.key({ altkey, "Control" }, "Up",
    --     function ()
    --         awful.util.spawn_with_shell("mpc toggle || ncmpc toggle || pms toggle")
    --         mpdwidget.update()
    --     end),
    -- awful.key({ altkey, "Control" }, "Down",
    --     function ()
    --         awful.util.spawn_with_shell("mpc stop || ncmpc stop || pms stop")
    --         mpdwidget.update()
    --     end),
    -- awful.key({ altkey, "Control" }, "Left",
    --     function ()
    --         awful.util.spawn_with_shell("mpc prev || ncmpc prev || pms prev")
    --         mpdwidget.update()
    --     end),
    -- awful.key({ altkey, "Control" }, "Right",
    --     function ()
    --         awful.util.spawn_with_shell("mpc next || ncmpc next || pms next")
    --         mpdwidget.update()
    --     end),


clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
-- root.keys(globalkeys)
-- }}}

--vim :set tabstop=4 shiftwidth=4 expandtab
