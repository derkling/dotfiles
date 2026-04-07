# ~/.config/fish/conf.d/00_common.fish
# This file bridges the gap between Fish and the shared POSIX configuration.
# It allows Fish to ingestion variables and aliases from standard shell files
# without manually translating every line.

# Function to parse and load standard 'export KEY="VALUE"' variables into Fish.
function load_posix_vars
    set -l file $argv[1]
    if not test -f "$file"
        return
    end
    # We iterate over lines starting with 'export ' and extract the key-value pair.
    for line in (grep "^export " "$file")
        set -l kv (string replace "export " "" "$line" | string replace -a '"' '' | string split -m 1 '=')
        set -gx $kv[1] $kv[2]
    end
end

# Function to parse and load standard POSIX 'alias name=\'command\'' aliases into Fish.
function load_posix_aliases
    set -l file $argv[1]
    if not test -f "$file"
        return
    end
    # Use bash to parse the file and evaluate all logic (like if/case).
    # This ensures that hostname-specific aliases are correctly handled.
    # We use env -i bash --norc --noprofile to ensure we only get aliases from the file.
    for line in (env -i bash --norc --noprofile -c "source $file; alias" 2>/dev/null)
        # Bash output: alias name='value'
        # We transform it to: alias name 'value' for Fish.
        set -l cmd (string replace -m 1 "=" " " "$line")
        eval "$cmd"
    end
end

# Ensure local binaries and user-specific tools are in the PATH.
fish_add_path $HOME/.local/bin
if test -f "$HOME/.dotfiles_profile"
    for profile in (cat "$HOME/.dotfiles_profile")
        fish_add_path "$HOME/.local/bin/$profile"
    end
end
fish_add_path /google/data/rw/users/de/derkling/tools
fish_add_path $HOME/.npm-global/bin

# Load the shared "Single Source of Truth" configuration.
load_posix_vars $HOME/.config/shell/vars.sh
load_posix_aliases $HOME/.config/shell/aliases.sh
