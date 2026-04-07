# ~/.profile
# Sourced by all login shells (sh, bash, zsh).

if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Source .bashrc if it exists and we are running in Bash.
# This ensures that login sessions (like SSH) correctly load the shared
# environment and trigger the interactive shell switch defined in .bashrc.
if [ -n "$BASH_VERSION" ]; then
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi
