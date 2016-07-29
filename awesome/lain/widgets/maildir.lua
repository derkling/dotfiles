
--[[
                                                  
     Licensed under GNU General Public License v2 
      * (c) 2013,      Luke Bonham                
      * (c) 2010-2012, Peter Hofmann              
                                                  
--]]

local newtimer        = require("lain.helpers").newtimer
local read_pipe       = require("lain.helpers").read_pipe
local set_map         = require("lain.helpers").set_map
local get_map         = require("lain.helpers").get_map
local spairs          = require("lain.helpers").spairs
local icons_dir       = require("lain.helpers").icons_dir

local wibox           = require("wibox")

local awful           = require("awful")
local util            = require("lain.util")

local mouse           = mouse

local io              = { popen  = io.popen }
local os              = { getenv = os.getenv }
local pairs           = pairs
local string          = { len    = string.len,
                          match  = string.match }

local setmetatable    = setmetatable

-- Maildir check
-- lain.widgets.maildir
local maildir = {}

local function worker(args)
    local args         = args or {}
    local timeout      = args.timeout or 60
    local mailpath     = args.mailpath or os.getenv("HOME") .. "/Mail"
    local list_boxes   = args.list_boxes or {}
    local ignore_boxes = args.ignore_boxes or {}
    local settings     = args.settings or function() end
    local ext_mail_cmd = args.external_mail_cmd
    local followmouse  = args.followmouse or false

    set_map(mail, 0)
    maildir.widget = wibox.widget.textbox('')

    function update()
        if ext_mail_cmd ~= nil
        then
            awful.util.spawn(ext_mail_cmd)
        end

        -- Find pathes to mailboxes.
        local p = io.popen("find " .. mailpath ..
                           " -mindepth 1 -maxdepth 1 -type d" ..
                           " -not -name .git")
        local boxes = {}
        repeat
            line = p:read("*l")
            if line ~= nil
            then

                -- Strip off leading mailpath.
                local box = string.match(line, mailpath .. "/(.*)")

		-- Skip maildirs not part of the required list
		if box ~= nil and
		   next(list_boxes) == nil or
		   util.element_in_table(box, list_boxes) then

			-- Find all files in the "new" subdirectory. For each
			-- file, print a single character (no newline). Don't
			-- match files that begin with a dot.
			-- Afterwards the length of this string is the number of
			-- new mails in that box.
			local mailstring = read_pipe("find " .. line ..
					    "/new -mindepth 1 -type f " ..
					    "-not -name '.*' -printf a")

			local nummails = string.len(mailstring)
			if nummails > 0
			then
			    boxes[box] = nummails
			end
		end
            end
        until line == nil

        p:close()

        newmail = "no mail"
        -- Count the total number of mails irrespective of where it was found
        total = 0

        for box, number in spairs(boxes)
        do
            -- Add this box only if it's not to be ignored.
            if not util.element_in_table(box, ignore_boxes)
            then
                total = total + number
                if newmail == "no mail"
                then
                    newmail = box .. "(" .. number .. ")"
                else
                    newmail = newmail .. "<br>" ..
                              box .. "(" .. number .. ")"
                end
	    else
		naughty.notify({text = "Skipping " .. box, timeout=4 })
            end
        end

        widget = maildir.widget
        settings()

	if total >= 1 and total > get_map(mail)
	then
		mail_notification_preset = {
			icon     = icons_dir .. "mail.png",
			position = "top_right"
		}
		if followmouse then
			mail_notification_preset.screen = mouse.screen
		end
		naughty.notify({
			preset = mail_notification_preset,
			text = newmail,
			timeout = 300
		})
	end
	set_map(mail, total)

     end

    newtimer(mailpath, timeout, update, true)
    return maildir.widget
end

return setmetatable(maildir, { __call = function(_, ...) return worker(...) end })
