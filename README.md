# Dotfiles

Personal configuration files for Linux, Vim/Neovim, Git, and various shell tools.
Designed for **Fedora Sway Atomic** (Sericea) and **Debian/Ubuntu** systems.

## Why this setup?
- **Symlink-Free**: Managed as a **bare Git repository** (`~/.dotfiles`),
  avoiding the clutter of symlink managers.
- **Atomic-Ready**: Optimized for Fedora's immutable variants with automated
  host layering and toolbox provisioning.
- **Privacy-First**: A **Layered Profile Strategy** keeps private tokens and
  identities out of the public Git history.
- **Single Source of Truth**: Shared shell logic and binaries ensure a consistent
  experience across Bash, Zsh, and Fish.

---

## Quick Start (Bootstrap)

Replicate this entire environment on a fresh installation with one command. It
installs `git`, clones the repo, provisions system packages, and initializes the
default toolbox.

```bash
curl -sL https://raw.githubusercontent.com/derkling/dotfiles/master/bootstrap.sh | bash
```

### Manual Installation
1. **Clone**: `git clone --no-checkout https://github.com/derkling/dotfiles.git $HOME/.dotfiles`
2. **Checkout**: `/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME checkout -f`
3. **Provision**: `make -C ~/.config bootstrap` (Detects OS and installs deps).

---

## Key Features

### 1. Layered Profile Strategy
Load different identities (e.g., `work`, `lab`) based on a profile file:
```bash
echo "work" > ~/.dotfiles_profile
```
| Subsystem | Tracked (Generic) | Ignored (Profile-Specific) |
| :--- | :--- | :--- |
| **Git Identity** | `~/.config/git/config` | `~/.config/git/config.{profile}` |
| **Shell Vars** | `~/.config/shell/vars.sh` | `~/.config/shell/vars.{profile}.sh` |
| **SSH Config** | `~/.ssh/config` | `~/.ssh/config.d/{profile}` |
| **Binaries** | `~/.local/bin/` | `~/.local/bin/{profile}/` |

### 2. Dependency Management (`Fedfiles`)
Dependencies are tracked in `~/.config/Fedfile.*` and `~/.config/Debfile*`.
- `Fedfile.system`: Host packages for `rpm-ostree`.
- `Fedfile.toolbox`: Development tools for the default container.
- `Debfile`: Core packages for Debian/Ubuntu systems.

### 3. Automatic Toolbox Entry
On Atomic systems, spawning an interactive shell on the host automatically
teleports you into the default `fedora-toolbox-43` (or current version). Use
`exit` to return to the host shell.

---

## Customization & Extension

### 1. Adding New Packages
1. Add the tool name and an inline comment to the appropriate `Fedfile.*` or `Debfile`.
2. Run `make -C ~/.config bootstrap` to apply changes.

### 2. Known Issues & Workarounds

#### NordVPN on Fedora Atomic
**Warning:** Version 4.5.0+ currently suffers from a packaging bug ("Invalid mode
2147500525") that prevents `rpm-ostree` from importing the RPM. You must use
version **4.3.1** or **3.18.5**.

1. **Install the Repository:**
   ```bash
   sudo rpm-ostree install \
       https://repo.nordvpn.com/yum/nordvpn/centos/noarch/Packages/n/nordvpn-release-1.0.0-1.noarch.rpm
   ```
2. **Install the Client (Pinned Version):**
   ```bash
   sudo rpm-ostree install \
       https://repo.nordvpn.com/yum/nordvpn/centos/x86_64/Packages/n/nordvpn-4.3.1-1.x86_64.rpm \
       https://repo.nordvpn.com/yum/nordvpn/centos/x86_64/Packages/n/nordvpn-gui-4.3.1-1.x86_64.rpm
   ```
3. **Post-Install Setup:**
   After rebooting, add your user to the group and enable the service:
   ```bash
   sudo usermod -aG nordvpn $USER
   sudo systemctl enable --now nordvpnd
   ```

### 3. Adding Shell Aliases
- **Global**: Add to `~/.config/shell/aliases.sh` (Shared by all shells).
- **Fish Specific**: Add a function to `~/.config/fish/functions/`.

### Profile-Specific Secrets
To add a private API key for the `work` profile:
1. Create `~/.config/shell/vars.work.sh`.
2. Add `export API_KEY="secret_value"`.
3. It will be sourced automatically but never committed.

---

## Subsystems

### Terminal & Editor
- **Alacritty**: GPU-accelerated terminal with Wayland support.
- **Neovim**: Modern setup using `lazy.nvim`. Features include a discoverable
  menu system via `which-key`, project-wide search, and modern LSP support.
  The first launch auto-installs all plugins.
- **Tmux**: Advanced terminal multiplexer with session persistence (via
  `tmux-resurrect`) and a discoverable
  [cheatsheet](.config/tmux/tmux-cheatsheet.md).
- **Yazi & Zathura**: Integrated CLI file management with PDF previews and
  lightweight viewing.

### Power Management & Appearance (Sway)
- Use `$mod+Escape` to enter the system mode:
  - `l`: Lock screen
  - `s`: Suspend (Locks before suspending)
  - `h`: Hibernate (Locks before hibernating)
- **Wallpaper**: The lock screen background is refreshed from Picsum on every
  unlock (`refresh-lock-bg`). If you like a wallpaper, run `lock-bg-keep` to save
  it to `~/Pictures/Wallpapers/`.
- **Window Properties**: To find properties for `for_window` rules, run:
  `sleep 2; swaymsg -t get_tree | jq '.. | select(.type?) | select(.focused==true)'`

---

## Management

Use the `config` alias to manage your dotfiles:
```bash
config status
config add .bashrc
config commit -m "[Shell] Update bashrc"
config push
```

---
**Author:** Patrick Bellasi ([github.com/derkling](https://github.com/derkling))
