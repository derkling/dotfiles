# ~/.config/fish/conf.d/google.fish
# Google-specific functions (Logic that requires Fish internal state)

# 1. Directory Switchers (These must be functions to change the parent shell's CWD)
function hg_d
    set -l citc $argv[1]
    if test -z "$citc"
        set citc (hg citc -l | fzf)
    end
    cd /google/src/cloud/$USER/$citc/google3
end

function hg_r
    if string match -r "/google/src/cloud/$USER/([^/]+)" "$PWD" > /dev/null
        set -l parts (string match -r "/google/src/cloud/$USER/([^/]+)" "$PWD")
        cd "/google/src/cloud/$USER/$parts[2]/google3"
    end
end

function bb
    if string match -r '(.*)/blaze-bin(.*)' "$PWD" > /dev/null
        set -l parts (string match -r '(.*)/blaze-bin(.*)' "$PWD")
        cd "$parts[2]$parts[3]"
    else
        cd (string replace "/google3/" "/google3/blaze-bin/" "$PWD")
    end
end

function work
    set -l session $argv[1]
    if test -z "$session"
        set session "work"
    end
    tmx2 new-session -A -s $session
end

# 2. State-dependent logic (Environment Variable Management)
function dr_machine
    set -l machine $argv[1]
    if test -z "$machine"
        set machine (reservation.par ls | grep -E ".*" | cut -d' ' -f4 | fzf)
    end
    set -gx MACHINE $machine
    echo "Using machine [$MACHINE]"
end

# 3. Prompt
function fish_prompt
    set -l last_status $status
    set -l full_host (hostname)
    set -l host (hostname -s | string replace -r '(\.corp\.google\.com|\.googlers\.com)' '')
    
    # Environment detection (Laptop vs Cloud/Remote)
    set -l env_emoji "💻"
    if set -q SSH_CONNECTION; or string match -q "*.c.googlers.com" "$full_host"
        set env_emoji "🌐"
    end

    # Machine-specific hostname coloring
    set -l host_color blue
    if string match -q "*.c.googlers.com" "$full_host"
        # Cloudtop: Bold Blue
        set host_color (set_color -o blue)
    else if string match -q "derkling5" "$host"
        # Local Machine: Bold Green
        set host_color (set_color -o green)
    else
        set host_color (set_color blue)
    end

    set -l g3_info ""
    if string match -r '/google/src/cloud/[^/]+/([^/]+)/google3/?(.*)' "$PWD" > /dev/null
        set -l parts (string match -r '/google/src/cloud/[^/]+/([^/]+)/google3/?(.*)' "$PWD")
        set -l citc_name $parts[2]
        set -l sub_path $parts[3]
        set g3_info (set_color yellow)"($citc_name) "(set_color green)"//$sub_path"
    else
        set -l collapsed_pwd (string replace "$HOME" "~" "$PWD")
        set g3_info (set_color green)"$collapsed_pwd"
    end

    echo -n "$env_emoji "(set_color green)"$USER"(set_color normal)"@$host_color$host "(set_color yellow)"$g3_info"
    echo
    echo -n (set_color normal)"# "
end

# 4. Initials
zoxide init fish | source

