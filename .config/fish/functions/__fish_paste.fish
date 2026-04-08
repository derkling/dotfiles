function __fish_paste -d "Paste from the clipboard"
    set -l data (wl-paste -n 2>/dev/null)
    if test -n "$data"
        # If --insert-smart is causing issues, use --insert
        commandline --insert -- $data
    end
end
