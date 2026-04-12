function fish_mode_prompt --description 'Displays the current mode and toolbox indicator'
    # Add a toolbox indicator if running in a toolbox
    if test -f /run/.containerenv
        # Use Nerd Font icon nf-oct-package () in bold yellow
        set_color -o yellow
        echo -n \uf487" "
        set_color normal
    end
    # Reuse the default mode indicator
    fish_default_mode_prompt
end
