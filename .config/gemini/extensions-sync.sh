#!/usr/bin/env bash
set -euo pipefail

# This script manages Gemini CLI extensions.
# It is meant to be called manually by the user when needed.

CONFIG_DIR=$(dirname "$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)")
. "$CONFIG_DIR/scripts/ansi"

# Ensure gemini is available
# Support for gemini being an alias
shopt -s expand_aliases
if [ -f "$HOME/.config/shell/aliases.sh" ]; then
    # shellcheck source=/dev/null
    . "$HOME/.config/shell/aliases.sh"
fi

if ! type gemini &>/dev/null; then
    ansi --red "Gemini CLI not found."
    ansi --yellow "Please ensure 'gemini' is installed or aliased before running this script."
    exit 1
fi

# Function to install extensions from a file
install_from_file() {
    local file=$1
    if [[ ! -f "$file" ]]; then
        return
    fi
    ansi --green "Installing Gemini extensions from $file"
    while IFS= read -r line || [[ -n "$line" ]]; do
        # Strip leading/trailing whitespace
        line=$(echo "$line" | xargs)
        [[ -z "$line" || "$line" == "#"* ]] && continue

        if [[ "$line" =~ ^https?:// ]]; then
            ansi --blue "  Installing $line"
            # Use -- to pass arguments correctly to the underlying tool
            gemini -- extensions install "$line" || true
        elif [[ -d "$line" ]]; then
            ansi --blue "  Linking $line"
            gemini -- extensions link "$line" || true
        else
            ansi --yellow "  Skipping $line (not a URL or directory)"
        fi
    done < "$file"
}

# 1. Install general extensions
install_from_file "$CONFIG_DIR/gemini/GeminiExtensions.general"

# 2. Install profile-specific extensions
if [ -f "$HOME/.dotfiles_profile" ]; then
    for profile in $(cat "$HOME/.dotfiles_profile"); do
        install_from_file "$CONFIG_DIR/gemini/GeminiExtensions.$profile"
    done
fi
