if status is-interactive
	# Use VIM key bindings
	fish_vi_key_bindings
	# These bindings are mostly convenience to use the same cords in both
	# Emacs and VIM mode. However, in VIM mode, an history search can
	# be triggered anyway by pressing "/" while in [N]ormal mode.
	bind -M insert \cr history-pager
	bind -M default \cr history-pager
end
