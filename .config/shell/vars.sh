# Shared Environment Variables (POSIX compatible)
# This file is sourced by Bash/Zsh and parsed by Fish.

export EDITOR="nvim"
export VISUAL="nvim"
export BROWSER="google-chrome"

export GO111MODULE=on

# Multi-Profile Loader:
# Load context-specific variables based on ~/.dotfiles_profile
if [ -f "$HOME/.dotfiles_profile" ]; then
    export DOTFILES_PROFILE=$(cat "$HOME/.dotfiles_profile" | head -n 1)
    for profile in $(cat "$HOME/.dotfiles_profile"); do
        [ -f "$HOME/.config/shell/vars.$profile.sh" ] && . "$HOME/.config/shell/vars.$profile.sh"
    done
fi
