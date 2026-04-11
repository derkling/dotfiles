# Dotfiles

Personal configuration files for Linux, Vim/Neovim, Git, and various shell tools.

## Setup

These dotfiles are managed using a bare Git repository stored in `~/.dotfiles`.
This allows managing configuration files directly in the `$HOME` directory
without messy symlinks.

### 1. Installation

From the home directory of a freshly installed Linux machine:

```bash
# Install git
sudo apt-get install git

# Clone bare git repo locally
git clone --no-checkout <repository_url> $HOME/.dotfiles

# Define the 'config' path for management (initial setup)
export PATH="$HOME/.local/bin:$PATH"

# Checkout the configuration files to your home directory
/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME checkout -f
/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME config --local status.showUntrackedFiles no

# Update submodules
/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME submodule update --init --recursive
```

### 2. Profile Activation

This repository supports a **Multi-Profile Strategy**. Beside the generic
configuration, you can activate one or more custom profiles (e.g., `work`,
`lab`) to load specific identities, variables, and tools.

To set the active profile for a machine:

```bash
echo "work" > ~/.dotfiles_profile
```

---

## Fedora Sway Atomic (Sericea)

On immutable Fedora variants, system-level tools are managed via `rpm-ostree`.

### 1. Base Package Layering

Install the core CLI and GUI tools required for this configuration:

```bash
sudo rpm-ostree install \
    alacritty distrobox eza fish fzf git neovim tig tmux zoxide
```

### 2. NordVPN Installation

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

---

## Split Configuration Strategy

To allow these dotfiles to be safely shared on public repositories while
maintaining access to private or context-specific tools, a **Layered Profile**
strategy is used.

### Generic vs. Profile-Specific Settings

Tracked files contain generic configurations. Context-specific data lives in
local files suffixed with the profile name, which are ignored by Git.

| Subsystem | Generic (Tracked) | Profile-Specific (Ignored) |
| :--- | :--- | :--- |
| **Git Identity** | `~/.config/git/config` | `~/.config/git/config.{profile}` |
| **Shell Vars** | `~/.config/shell/vars.sh` | `~/.config/shell/vars.{profile}.sh` |
| **SSH Config** | `~/.ssh/config` | `~/.ssh/config.d/{profile}` |
| **Binaries** | `~/.local/bin/` | `~/.local/bin/{profile}/` |

### Adding Custom Settings

1.  **Environment Variables**: Add context-specific tokens or paths to
    `~/.config/shell/vars.{profile}.sh`.
2.  **Git**: Add specific email or signing keys to `~/.config/git/config.{profile}`.
3.  **SSH**: Add hostnames and identity files to `~/.ssh/config.d/{profile}`.
4.  **Binaries**: Place context-specific scripts in `~/.local/bin/{profile}/`.

---

## Subsystems

### Terminal (Alacritty)

The recommended terminal emulator is **Alacritty**. It is a modern, fast, and
safe terminal written in Rust.

- **Wayland Native**: Works seamlessly on modern Linux desktops.
- **Configuration**: Managed via `~/.config/alacritty/alacritty.toml`.

### Neovim (Modern Setup)

Powered by [lazy.nvim](https://github.com/folke/lazy.nvim).

- **Bootstrapping**: Launching `nvim` automatically installs the plugin manager
  and all configured plugins.
- **Key Features**: Discoverable menu system via `which-key`, built-in project
  search, and modern LSP support.

---

## Management

Use the `config` alias to manage your dotfiles:

```bash
config status
config add .bashrc
config commit -m "[Shell] Update bashrc"
config push
```

### Shell (Fish & Bash)

- **Entry Point**: **Bash** is the login shell and handles the transition to the
  interactive shell.
- **Priority**: **Fish** (if available) -> **Zsh** -> **Bash**.
- **Single Source of Truth**: Shared logic lives in `~/.config/shell/` and
  `~/.local/bin/` to ensure consistency across all shells.

---

### Wallpaper Management

The lock screen background is automatically refreshed using a script that
fetches a random 2K image from Picsum.

- **Refresh**: `refresh-lock-bg` updates `~/.cache/lock-screen-bg.jpg`.
- **Backup**: Each refresh keeps the *previous* image at
  `~/.cache/lock-screen-bg.jpg.old`.
- **Preserve**: If you liked a previous wallpaper, run `lock-bg-keep` to
  save a permanent copy into `~/Pictures/Wallpapers/`.

---
**Author:** Patrick Bellasi ([github.com/derkling](https://github.com/derkling))
