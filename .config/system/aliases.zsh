
################################################################################
# Enable color support
################################################################################

if [ "$TERM" != "dumb" ] && [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

if [ "x$TMUX_PANE" != "x" ]; then
    export TERM="screen-256color"
elif [ -n "$DISPLAY" -a "$TERM"=="xterm" ]; then
    export TERM="xterm-256color"
fi

if $(grc &>/dev/null)
then
  alias configure='stdbuf -oL grc --colour=auto configure'
  alias diff='stdbuf -oL grc --colour=auto diff'
  alias gcc='stdbuf -oL grc --colour=auto gcc'
  alias llog='stdbuf -oL grc --colour=auto less'
  alias netstat='stdbuf -oL grc --colour=auto netstat'
  alias ping='stdbuf -oL grc --colour=auto ping'
  alias traceroute='stdbuf -oL grc --colour=auto traceroute'
  alias wdiff='stdbuf -oL grc --colour=auto wdiff'
fi

################################################################################
# Files and Directory utilities
################################################################################

alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

alias dir='ls --color=auto --format=vertical'
alias vdir='ls --color=auto --format=long'

################################################################################
# Commonly used commands
################################################################################

alias ta='tmux attach -t'
alias tl='tmux list-sessions'
alias tm='tmux -2' # Force 256 color mode
alias ts='tmux new-session -s'

################################################################################
# Customized command options
################################################################################

alias ranger="ranger --confdir=$HOME/dotfiles/ranger"

alias confs='unity-control-center'
alias sound='unity-control-center sound'
