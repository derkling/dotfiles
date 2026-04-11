# Shared Aliases (POSIX compatible)
# This file is sourced by Bash/Zsh and parsed by Fish.

# Google Tools
alias aclcheck='/google/bin/releases/ganpati-acls/tools/aclcheck'
alias aristotle_cli='/google/bin/releases/aristotle/cli/bin/production/aristotle/cli/aristotle_cli.par'
alias bgrep='/google/data/ro/teams/borgtools/bgrep'
alias bkick="bgrep --restart"
alias bkill='/google/data/ro/teams/borgtools/bkill'
alias btail='/google/data/ro/teams/borgtools/btail'
alias colab_start='/google/data/ro/teams/colab/notebook'
alias crash='/google/data/ro/projects/kdump/crash'
alias gbuild='/google/data/ro/projects/platforms/prodkernel/gbuild/current/gbuild'
alias gcloud='/google/data/ro/teams/cloud-sdk/gcloud'
alias gdb='/google/data/ro/projects/kdump/gdb'
alias gosso='/google/bin/releases/gosso/gosso'
alias gpaste='/google/src/head/depot/eng/tools/pastebin'
alias ice='/google/bin/releases/kernel-tools/icebreaker-release/ice'
alias ll='eza -al --color=always --group-directories-first'
alias kbug='/google/bin/releases/kernel-security-team/kbug'
alias kdt='/google/bin/releases/kernel-release/tools/kdt/kdt.par'
alias konjurer='/google/bin/releases/kernel-tools/konjurer/konjurer_cli'
alias kperf='/google/bin/releases/kernel-racktest/tests/kperf/kperf'
alias kue_cli='/google/bin/releases/kernel-racktest/kue/cli'
alias launch_candidate='/google/bin/releases/kernel-release/releng/rapid_tools/launch_candidate/launch_candidate.par'
alias missing_fixes='/google/bin/releases/kernel-tools/release_tools/missing_fixes'
alias mlq='/google/bin/releases/gce-node-sre/mlq/mlq'
alias msv='/google/bin/releases/msv-sre/clis/msv'
alias node_cli='/google/bin/releases/borg-sre/node_cli/node'
alias notmdb='/google/bin/releases/woodenshoes-admin/notmdb'
alias sendgmr='/google/bin/releases/gws-sre/files/sendgmr/sendgmr'
alias yogi='/google/data/ro/projects/yogi/cli'

# MIBA / SSH
alias dscp='/usr/bin/miba_ssh_session -a -- scp'
alias dssh='/usr/bin/miba_ssh_session -a -- ssh'
alias miba_destroy='gcertdestroy -f'
alias miba_policy_check='/google/bin/releases/miba-team/public/miba_policy_check'
alias miba_ssh_session='/google/src/head/depot/google3/security/ssh/miba/tools/miba_ssh_session'
alias miba_status='miba_ssh_session -a -- gcertstatus -format=miba'

# Shared GUtils Aliases
alias borg_machines='gutils borg_machines'
alias borg_master='gutils borg_master'
alias find_glogs='gutils find_glogs'
alias port_of='gutils port_of'

# Shared DevRez Aliases
alias dr_info='dr info'
alias dr_pull='dr pull'
alias dr_push='dr push'
alias dr_reserve='dr reserve'
alias dr_ssh='dr ssh'

# Utils
alias slabinfo="sudo cat /proc/slabinfo | sed 's/#//' | column -t"

# Host-specific Aliases
case "$(hostname)" in
  darkstar)
    alias gemini='toolbox run -c gemini gemini'
    ;;
  derkling5)
    alias gemini='/google/bin/releases/gemini-cli/tools/gemini --noproxy'
    ;;
  derkling)
    alias gemini='/google/bin/releases/gemini-cli/tools/gemini'
    ;;
  *) # Default aliases for other hosts
    ;;
esac
