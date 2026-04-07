
################################################################################
# Debian / Ubuntu specific aliases
################################################################################

# Do nothgin if we are not in a Debian based system
apt-get &>/dev/null || return

# Packages management actions
alias pkga="sudo aptitude install"
alias pkgr="sudo aptitude remove"
alias pkgR="sudo aptitude purge"
alias pkgs="aptitude search"
alias pkgi="aptitude show"
alias pkgd="aptitude download"
alias pkgS="apt-get source"
alias pkgl="dpkg -L"
alias pkgu="sudo aptitude update; sudo aptitude upgrade"

