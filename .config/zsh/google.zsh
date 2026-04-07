# ~/.config/zsh/google.zsh
# Refactored for shared architecture. 
# Shared logic moved to ~/.config/shell/ and ~/.local/bin/

# Piper commands completion
if [[ -f /etc/bash_completion.d/g4d ]]; then
  . /etc/bash_completion.d/p4
  . /etc/bash_completion.d/g4d
fi

# Borg SRE aliases
# These are typically provided by the system.
[[ -f /etc/zsh/zshrc.d/borg_sre_aliases.sh ]] && source /etc/zsh/zshrc.d/borg_sre_aliases.sh

# Load SHLib aliases
# Only if the shlib command exists and returns a valid file.
if command -v shlib &>/dev/null; then
    SHLIB_ALIAS=$(shlib find_shlib)
    [[ -f $SHLIB_ALIAS ]] && source $SHLIB_ALIAS
fi

function bdown() {
    COL=$1
    if command -v shlib &>/dev/null; then
        shlib frequency_table $COL | sort -nk2
    else
        echo "shlib command not found"
    fi
}

################################################################################
# Prompt
################################################################################
function host_prompt_info() {
    print -r ${$(uname -n)/(\.corp\.google\.com|\.googlers\.com)/}
}

function collapse_pwd {
    echo $(pwd | sed -e "s,^$HOME,~,")
}

function g3_prompt_info() {
  if [[ $PWD =~ '/google/src/cloud/[^/]+/(.+)/google3(.*)' ]]; then
    print -r -- "%F{yellow}(${match[1]}) %F{green}//${match[1]#/}"
  else
    print -r -- "%F{green}$(collapse_pwd)"
  fi
}

setopt prompt_subst
PROMPT='
%{%K{${bkg}%B%F{green}%}%n%{%B%F{blue}%}@$(host_prompt_info) %{%F{yellow}%}$(g3_prompt_info) %E
 %# %{%f%k%b%}'

################################################################################
# Stateful Directory Switchers
################################################################################

function hg_d() {
  CITC=${1:-$(hg citc -l | fzf)}
  cd /google/src/cloud/${USER}/${CITC}/google3
}

function hg_r() {
  [[ $PWD =~ "/google/src/cloud/${USER}/([^/]+)" ]] || return
  CITC=${match[1]}
  cd "/google/src/cloud/${USER}/${CITC}/google3"
}

function bb() {
  if [[ $PWD =~ '(.*)/blaze-bin(.*)' ]]; then
    cd "${match[1]}${match[2]}"
  else
    cd "${PWD/\/google3//google3/blaze-bin}"
  fi
}

function work() {
  SESSION=${1:-work}
  tmx2 new-session -A -s ${SESSION}
}

function dr_machine() {
  MACHINE=${1}
  [[ ! -z ${MACHINE} ]] || MACHINE=$(reservation.par ls | awk '{print $4}' | fzf)
  export MACHINE=$MACHINE
  echo "Using machine [${MACHINE}]"
}
