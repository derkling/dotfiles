# -*- coding: utf-8 -*-
# Copyright (C) 2009, 2010, 2011  Roman Zimbelmann <romanz@lavabit.com>
# This configuration file is licensed under the same terms as ranger.
# ===================================================================
# This is an example of ranger plugin written in Python.
#
# Lines beginning with # are comments.  To enable a line, remove the #.
# ===================================================================

from ranger.api.options import *

## Apply an overlay function to the colorscheme.  It will be called with
## 4 arguments: the context and the 3 values (fg, bg, attr) returned by
## the original use() function of your colorscheme.  The return value
## must be a 3-tuple of (fg, bg, attr).
## Note: Here, the colors/attributes aren't directly imported into
## the namespace but have to be accessed with color.xyz.

#from ranger.gui import color
#def colorscheme_overlay(context, fg, bg, attr):
#	if context.directory and attr & color.bold and \
#			not any((context.marked, context.selected)):
#		attr ^= color.bold  # I don't like bold directories!
#
#	if context.main_column and context.selected:
#		fg, bg = color.red, color.default  # To highlight the main column!
#
#	return fg, bg, attr


# ===================================================================
# Beware: from here on, you are on your own.  This part requires python
# knowledge.
#
# Since python is a dynamic language, it gives you the power to replace any
# part of ranger without touching the code.  This is commonly referred to as
# Monkey Patching and can be helpful if you, for some reason, don't want to
# modify rangers code directly.  Just remember: the more you mess around, the
# more likely it is to break when you switch to another version.
#
# Here are some practical examples of monkey patching.
#
# Technical information:  This file is imported as a python module.  If a
# variable has the name of a setting, ranger will attempt to use it to change
# that setting.  You can write "del <variable-name>" to avoid that.
# ===================================================================
# Add a new sorting algorithm: Random sort.
# Enable this with :set sort=random

#from ranger.fsobject.directory import Directory
#from random import random
#Directory.sort_dict['random'] = lambda path: random()

# ===================================================================
# A function that changes which files are displayed.  This is more powerful
# than the hidden_filter setting since this function has more information.

## Save the original filter function
#import ranger.fsobject.directory
#old_accept_file = ranger.fsobject.directory.accept_file
#
## Define a new one
#def accept_file_MOD(fname, mypath, hidden_filter, name_filter):
#	if hidden_filter and mypath == '/' and fname in ('boot', 'sbin', 'proc', 'sys'):
#		return False
#	else:
#		return old_accept_file(fname, mypath, hidden_filter, name_filter)
#
## Overwrite the old function
#import ranger.fsobject.directory
#ranger.fsobject.directory.accept_file = accept_file_MOD

# ===================================================================
# A function that adds an additional macro.  Test this with :shell -p echo %date

## Save the original macro function
#import ranger.core.actions
#old_get_macros = ranger.core.actions.Actions._get_macros
#
## Define a new macro function
#import time
#def get_macros_MOD(self):
#	macros = old_get_macros(self)
#	macros['date'] = time.strftime('%m/%d/%Y')
#	return macros
#
## Overwrite the old one
#ranger.core.actions.Actions._get_macros = get_macros_MOD
