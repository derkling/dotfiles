#!/usr/bin/env bash
set -euo pipefail

DIR=$(dirname "$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)")
. "$DIR/scripts/base.sh"
. "$DIR/scripts/ansi"

export HOMEBREW_BUNDLE_FILE="$DIR/Brewfile"
export DEBIAN_BUNDLE_FILE="$DIR/dependencies.debian"
export DEBIAN_EXTRA_BUNDLE_FILE="$DIR/dependencies.debian_extra"
export FEDORA_ATOMIC_BUNDLE_FILE="$DIR/dependencies.fedora_atomic"
export PACMAN_BUNDLE_FILE="$DIR/Pacfile"

if [[ "$OSTYPE" == "darwin"* ]]; then
	ansi --green "Using $HOMEBREW_BUNDLE_FILE bundle file"
	brew bundle
	exit 0
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
	if which apt-get &>/dev/null; then
		OSTYPE="debian"
	elif which rpm-ostree &>/dev/null; then
		OSTYPE="fedora_atomic"
	elif which pamac &>/dev/null; then
		OSTYPE="arch"
	fi
fi

# ask sudo upfront
sudo -v
if [[ "${OSTYPE:?}" == "debian"* ]]; then
	sudo apt-get update
	ansi --green "Using $DEBIAN_BUNDLE_FILE bundle file"
	sudo apt-get install $(grep -e '^[a-zA-Z]' "$DEBIAN_BUNDLE_FILE")
	if [ -f "$DEBIAN_EXTRA_BUNDLE_FILE" ]; then
		ansi --green "Using $DEBIAN_EXTRA_BUNDLE_FILE bundle file"
		sudo apt-get install $(grep -e '^[a-zA-Z]' "$DEBIAN_EXTRA_BUNDLE_FILE")
	fi
elif [[ "${OSTYPE:?}" == "fedora_atomic"* ]]; then
	ansi --green "Using $FEDORA_ATOMIC_BUNDLE_FILE bundle file"
	ansi --yellow "Run the following command OUTSIDE of the toolbox:"
	echo "  rpm-ostree install \$(grep -v '^#' $FEDORA_ATOMIC_BUNDLE_FILE | xargs)"
elif [[ "${OSTYPE:?}" == "arch"* ]]; then
	# ask sudo upfront
	sudo -v
	sudo pacman -Syy
	ansi --green "Using $PACMAN_BUNDLE_FILE bundle file"
	sudo pacman -S --noconfirm --needed - <"$PACMAN_BUNDLE_FILE"
fi
