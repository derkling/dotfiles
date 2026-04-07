#!/usr/bin/env bash
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
. "$DIR/base.sh"

VIM_PLUG_PATH="$HOME/.vim/bundle/vundle"
if [[ -d "$VIM_PLUG_PATH" && -x "$(command -v vim)" ]]; then
	vim +BundleInstall +qall
fi
