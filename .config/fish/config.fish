if status is-interactive
  # Fedora Atomic: Teleport to the home folder
  # If we are inside a toolbox...
  if test -f /run/.containerenv
    # ... the PWD starts with /var/home
    if string match -q "/var/home/*" $PWD
      # Replace /var/home with /home and move there silently
      cd (string replace "/var/home" "/home" $PWD)
    end
  else
    # Not in a toolbox. If we're on a Fedora Atomic system, teleport to the
    # default fedora-toolbox container.
    if test -f /run/host/etc/os-release; and grep -q "VARIANT_ID=.*-atomic" /run/host/etc/os-release
        # Get the OS version to target the specific toolbox
        set -l os_version (grep "^VERSION_ID=" /run/host/etc/os-release | cut -d'=' -f2 | tr -d '"')
        set -l default_toolbox "fedora-toolbox-$os_version"

        # Only enter the toolbox if not in an SSH or serial session
        if test -z "$SSH_TTY"
            # Use toolbox enter if the default toolbox exists
            if toolbox list --containers | grep -q "$default_toolbox"
                # Enter the toolbox (without exec, to allow returning to host)
                toolbox enter "$default_toolbox"
            end
        end

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
