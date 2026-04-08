if status is-interactive
        # Fedora Atomic: Teleport to the home folder
        # If we are inside a toolbox...
        if test -f /run/.containerenv
            # ... the PWD starts with /var/home
            if string match -q "/var/home/*" $PWD
                # Replace /var/home with /home and move there silently
                cd (string replace "/var/home" "/home" $PWD)
            end
        end

	# Use VIM key bindings
	fish_vi_key_bindings
	# These bindings are mostly convenience to use the same cords in both
	# Emacs and VIM mode. However, in VIM mode, an history search can
	# be triggered anyway by pressing "/" while in [N]ormal mode.
	bind -M insert \cr history-pager
	bind -M default \cr history-pager
end
