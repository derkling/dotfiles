# ~/.bashrc refactored
# Primary entry point for interactive and non-interactive sessions.
# This file is responsible for loading the shared cross-shell configuration
# and automatically transitioning to a more modern interactive shell (Fish).

# 1. Load shared environment and aliases (Standard POSIX)
# These files follow POSIX syntax so they can be sourced by Bash, Zsh, or parsed by Fish.
# Loading them here ensures that even non-interactive Bash scripts have access to common variables.
[[ -f ~/.config/shell/vars.sh ]] && . ~/.config/shell/vars.sh
[[ -f ~/.config/shell/aliases.sh ]] && . ~/.config/shell/aliases.sh

# 2. Add local bin to path (for standalone scripts)
# Standalone scripts in ~/.local/bin provide the "single source of truth" for complex logic.
export PATH="$HOME/.local/bin:/google/data/rw/users/de/derkling/tools:$HOME/.npm-global/bin:$PATH"

# 3. Interactive shell selection
# We only switch shells for interactive sessions to prevent breaking automated tools
# (like roadwarrior, gcert, rsync, etc.) that expect a standard Bash environment.
if [[ "$-" =~ i ]]; then
  # We use 'command -v' and silent blocks to ensure no noise is produced during login,
  # which avoids "inappropriate ioctl" errors in tools like gcert.
  {
    WHICH_FISH=$(command -v fish)
    WHICH_ZSH=$(command -v zsh)
  } 2>/dev/null

  # Prioritize Fish, fallback to Zsh, stay in Bash if neither are available.
  # We check for version variables to avoid infinite recursion if already in the target shell.
  if [[ -x "${WHICH_FISH}" && -z "$FISH_VERSION" ]]; then
    exec env SHELL="${WHICH_FISH}" "${WHICH_FISH}" -i
  elif [[ -x "${WHICH_ZSH}" && -z "$ZSH_VERSION" && -z "$FISH_VERSION" ]]; then
    exec env SHELL="${WHICH_ZSH}" "${WHICH_ZSH}" -i
  fi
fi
