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

## Split Configuration Strategy

To allow these dotfiles to be safely shared on public repositories while
maintaining access to private or context-specific tools, a **Layered Profile**
strategy is used.

### Generic vs. Profile-Specific Settings

Tracked files contain generic configurations. Context-specific data lives in
local files suffixed with the profile name, which are ignored by Git.

| Subsystem | Generic (Tracked) | Profile-Specific (Ignored) |
| :--- | :--- | :--- |
| **Git Identity** | `~/.gitconfig` | `~/.gitconfig.{profile}` |
| **Shell Vars** | `~/.config/shell/vars.sh` | `~/.config/shell/vars.{profile}.sh` |
| **SSH Config** | `~/.ssh/config` | `~/.ssh/config.{profile}` |
| **Binaries** | `~/.local/bin/` | `~/.local/bin/{profile}/` |

### Adding Custom Settings

1.  **Environment Variables**: Add context-specific tokens or paths to
    `~/.config/shell/vars.{profile}.sh`.
2.  **Git**: Add specific email or signing keys to `~/.gitconfig.{profile}`.
3.  **SSH**: Add hostnames and identity files to `~/.ssh/config.{profile}`.
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
**Author:** Patrick Bellasi ([github.com/derkling](https://github.com/derkling))
