function __fish_paste -d "Paste from the clipboard"
    set -l data $argv[1]

    # Fallback only if no data was passed as an argument
    if test -z "$data"
        if type -q wl-paste; and set -q WAYLAND_DISPLAY
            set data (wl-paste -n 2>/dev/null)
        else if type -q tmux; and set -q TMUX
            set data (tmux save-buffer - 2>/dev/null)
        end
    end

    if test -n "$data"
        # Use --insert instead of --insert-smart for better compatibility
        # across different Fish versions and environments (e.g. remote SSH).
        commandline --insert -- $data
    end
end
