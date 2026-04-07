# ~/.config/zsh/aliases.zsh
# Ported to shared architecture. Logic moved to ~/.config/shell/ and ~/.local/bin/

# Source shared environment and aliases
[[ -f ~/.config/shell/vars.sh ]] && source ~/.config/shell/vars.sh
[[ -f ~/.config/shell/aliases.sh ]] && source ~/.config/shell/aliases.sh

# Ensure local bin is in path
export PATH="$HOME/.local/bin:$PATH"

# All zsh-specific non-stateful aliases have been moved to shared files.
