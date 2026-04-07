#!/usr/bin/env bash
set -euo pipefail

DIR=$(dirname "$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)")
. "$DIR/scripts/base.sh"
. "$DIR/scripts/ansi"

export HOMEBREW_BUNDLE_FILE="$DIR/Brewfile"
export DEBIAN_BUNDLE_FILE="$DIR/Debfile"
export PACMAN_BUNDLE_FILE="$DIR/Pacfile"

if [[ "$OSTYPE" == "darwin"* ]]; then
	ansi --green "Using $HOMEBREW_BUNDLE_FILE bundle file"
	brew bundle
	exit 0
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
	if which apt-get &>/dev/null; then
		OSTYPE="debian"
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
elif [[ "${OSTYPE:?}" == "arch"* ]]; then
	# ask sudo upfront
	sudo -v
	sudo pacman -Syy
	ansi --green "Using $PACMAN_BUNDLE_FILE bundle file"
	sudo pacman -S --noconfirm --needed - <"$PACMAN_BUNDLE_FILE"
fi
