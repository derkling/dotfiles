#!/bin/bash
# bootstrap.sh - Standalone bootstrap script for Fedora Atomic and Debian dotfiles
#
# Usage:
#   curl -sL https://raw.githubusercontent.com/derkling/dotfiles/master/bootstrap.sh | bash

set -e

REPO_URL="https://github.com/derkling/dotfiles.git"
DOTFILES_DIR="$HOME/.dotfiles"

ansi_green() { echo -e "\033[0;32m$1\033[0m"; }
ansi_yellow() { echo -e "\033[0;33m$1\033[0m"; }

# 1. Detect Environment
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS_ID=$ID
    OS_VARIANT_ID=$VARIANT_ID
else
    OS_ID=$(uname -s | tr '[:upper:]' '[:lower:]')
fi

# 2. Ensure git is available
if ! command -v git &>/dev/null; then
    ansi_green "Installing git..."
    if [[ "$OS_VARIANT_ID" == *"-atomic"* ]]; then
        sudo rpm-ostree install --apply-live git
    elif [[ "$OS_ID" == "debian" ]] || [[ "$OS_ID" == "ubuntu" ]]; then
        sudo apt-get update && sudo apt-get install -y git
    else
        ansi_yellow "Unsupported OS for automatic git installation. Please install git manually."
        exit 1
    fi
fi

# 3. Clone/Checkout dotfiles
if [ ! -d "$DOTFILES_DIR" ]; then
    ansi_green "Cloning dotfiles repository..."
    git clone --bare "$REPO_URL" "$DOTFILES_DIR"
fi

config() {
    /usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME" "$@"
}

ansi_green "Checking out dotfiles..."
config config --local status.showUntrackedFiles no
if ! config checkout; then
    ansi_yellow "Existing files detected. Backing up and trying again..."
    mkdir -p .dotfiles-backup
    config checkout 2>&1 | grep -E "\s+\." | awk '{print $1}' | xargs -I{} mv {} .dotfiles-backup/{}
    config checkout
fi

# 4. Dispatch to internal scripts
if [[ "$OS_VARIANT_ID" == *"-atomic"* ]]; then
    ansi_green "Running Fedora Atomic bootstrap..."
    if [ -f "$HOME/.local/bin/bootstrap-system" ]; then
        bash "$HOME/.local/bin/bootstrap-system"
    else
        ansi_yellow "Internal bootstrap script not found at ~/.local/bin/bootstrap-system"
        exit 1
    fi
elif [[ "$OS_ID" == "debian" ]] || [[ "$OS_ID" == "ubuntu" ]]; then
    ansi_green "Running Debian/Ubuntu bootstrap..."
    # Debian uses the existing Makefile/install_deps.sh logic
    if [ -f "$HOME/.config/Makefile" ]; then
        make -C "$HOME/.config" install-deps
    else
        ansi_yellow "Makefile not found at ~/.config/Makefile"
        exit 1
    fi
else
    ansi_yellow "Environment detected as $OS_ID ($OS_VARIANT_ID), no specific bootstrap logic found."
fi
