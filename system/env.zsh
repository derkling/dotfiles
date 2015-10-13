# Only set this if we haven't set $EDITOR up somewhere else previously.
if [[ "$EDITOR" == "" ]] ; then
  # Use vim for my editor.
  export EDITOR='vim'
fi

# Filter files to less
if [ -x /usr/bin/lesspipe ]; then
  [ -n "$ZSH_VERSION" ] && \
	  eval "$(lesspipe)" # assume Zsh
  [ -n "$BASH_VERSION" ] && \
	  "$(SHELL=/bin/sh lesspipe)" #assume Bash
  fi

# Disable default mapping of Ctrs+S to the old-fashioned XON/XOFF flow control
# This mapping is used by the CommandT VIM plugin to open a selection in an
# horizontal split
stty -ixon -ixoff
