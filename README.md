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

### Adding New Packages
1. Add the tool name and an inline comment to the appropriate `Fedfile.*` or `Debfile`.
2. Run `make -C ~/.config bootstrap` to apply changes.

### Adding Shell Aliases
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
- **Neovim**: Modern setup using `lazy.nvim`. First launch auto-installs all
  plugins and LSPs.
- **Yazi & Zathura**: Integrated CLI file management with PDF previews and
  lightweight viewing.

### Power Management (Sway)
- Use `$mod+Escape` to enter the system mode:
  - `l`: Lock screen
  - `s`: Suspend (Locks before suspending)
  - `h`: Hibernate (Locks before hibernating)
- Wallpaper is refreshed from Picsum on every unlock (`refresh-lock-bg`).

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
