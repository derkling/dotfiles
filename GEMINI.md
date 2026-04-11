# GEMINI.md - Dotfiles Configuration Context

This directory (~/) is the work-tree for a "Single Source of Truth" dotfiles
management system. The configuration is designed to be cross-shell (Bash, Zsh,
Fish) and cross-machine.

## Core Setup
- **Operating System**: Linux
- **Window Manager**: Sway (Wayland)
- **Shell**: Fish (configured with Vi key bindings and custom history-pager)
- **Notification Daemon**: Mako
- **Service Manager**: Systemd (User instance manages session services)
- **Repository**: Bare git repo at `~/.dotfiles` managed via the `config`
  command.

## Key Configuration Locations
- **Fish Shell**: `~/.config/fish/config.fish` and `~/.config/fish/functions/`
- **Sway/Wayland**: `~/.config/sway/config`
- **Systemd User Services**: `~/.config/systemd/user/`
- **Shared Shell Tier**: `~/.config/shell/vars.sh` and `~/.config/shell/aliases.sh`
- **Standalone Binaries**: `~/.local/bin/` (ensures shell-agnostic behavior)

## Management & Modification Rules

### 1. Dotfiles Tracking (`config` command)
- **NEVER** use standard `git` commands in `$HOME` or `~/.config`.
- **ALWAYS** use the `config` command:
    - `config status`: Check modified files.
    - `config add <file>`: Stage changes (automatically uses `-f`).
    - `config commit -m "[Prefix] Description"`: Commit changes.
    - `config log --stat`: View history and prefix patterns.
- **Commit Message Convention**: Use a bracketed prefix based on the modified
  component (e.g., `[Shell]`, `[Fish]`, `[Sway]`, `[NVim]`, `[Config]`,
  `[SSH]`).
- **Atomic Changes**: Provide clear, atomic changes and explain *why* they are
  being made.

### 2. Systemd Services
- **NEVER** modify unit files in `/usr/lib/systemd/user/` or
  `/usr/lib/systemd/system/`.
- **ALWAYS** use user-specific drop-in overrides:
  `~/.config/systemd/user/<service>.service.d/override.conf`.
- **Activation**: After modifying, always run `systemctl --user daemon-reload`
  and restart the affected service.
- **Inspection**: Use `systemctl --user cat <service>` to view the effective
  merged configuration.

### 3. Fish Shell
- **Initialization**: `fish_vi_key_bindings` overrides default bindings. Custom
  `bind` commands must be placed *after* vi bindings are initialized in
  `config.fish`.
- **Testing**: Use `fish -c '<command>'` to test configurations
  non-interactively.
- **POSIX Bridge**: `00_common.fish` parses `aliases.sh` via `bash` to support
  POSIX logic (like `case` blocks) in Fish.

### 4. Neovim (v0.11+)
- **Markdown Rendering**: Use `:Glow` or `<leader>tm` for a terminal-based
  rendered preview.
- **Treesitter**: Uses the `main` branch. If parsers are missing, run
  `:TSInstall <lang>`.
- **Maintenance**: `make -C ~/.config clean-nvim` purges cache/state for a clean
  reinstall.

## Key Management Commands
- `make -C ~/.config install-deps`: Install packages from `~/.config/Debfile`.
- `config` (no args): Launches `tig` on the dotfiles repo.
    - `v` (inside Tig): View file in Glow/Browser/Editor.
    - `Q` (inside Tig): `quickfix` (fixup + autosquash rebase) on selected
      commit.

## Toolbox & Container Environment
- **Detection**: Check for the existence of `/run/.containerenv` or the presence
  of `VARIANT_ID=toolbx` in `/etc/os-release`.
- **Host Filesystem Access**: If running in a toolbox, the host's root filesystem
  is mounted at `/run/host`. You can read files there (e.g.,
  `cat /run/host/etc/systemd/system/nordvpn.service`), but you **CANNOT**
  directly execute commands on the host (like `systemctl`, `dnf`, or `rpm`).
- **Command Execution**: If a task requires host-side modifications (e.g.,
  enabling a system service or installing a host package), you **MUST** inform
  the user and ask them to run the command on the host system outside the
  toolbox.

## Recommended Diagnostic Tools
- `sanity-check`: Run a comprehensive system health and configuration check.
- `config status` / `config diff`: Check pending changes.
- `systemctl --user status <service>`: Check service health.
- `journalctl --user -u <service> -e`: Check recent logs for a service.
- `fish -i -c 'bind'`: Inspect current effective keybindings.
- `hostname`: Identify current machine for host-specific logic.
