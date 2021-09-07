#!/usr/bin/env bash

# Grabbed all these functions from https://github.com/rkalis/dotfiles/blob/master/scripts/functions.sh
# Then adapted to make them compatible with Bash (vs originally Fish)

set -e

symlink() {
	local SRC=$1
	local DST=$2
	local OVERWRITTEN=""

	if ! [[ -e "$SRC" ]]; then
		substep_error "$SRC does not exist!"
		return 1
	fi
	if [[ -e "$DST" ]] || [[ -h "$DST" ]]; then
		local CURRENT_SRC="$(readlink $DST)"
		if [[ "$CURRENT_SRC" == "$SRC" ]]; then
			substep_info "$DST symlinked to $SRC already."
			return 0
		fi
   
		OVERWRITTEN="(Overwritten)"
		if ! rm -rf "$DST"; then
			substep_error "Failed to remove existing file(s) at $DST."
		fi
	fi
	if ln -s "$SRC" "$DST"; then
		substep_success "Symlinked $DST to $SRC. $OVERWRITTEN"
	else
		substep_error "Symlinking $DST to $SRC failed."
	fi
}

clear_broken_symlinks() {
    find -L "$1" -type l | while read fn; do
        if rm "$fn"; then
            substep_success "Removed broken symlink at $fn."
        else
            substep_error "Failed to remove broken symlink at $fn."
        fi
    done
}

# Took these printing functions from https://github.com/Sajjadhosn/dotfiles
coloredEcho() {
    local exp="$1";
    local color="$2";
    local arrow="$3";
    if ! [[ $color =~ '^[0-9]$' ]] ; then
       case $(echo $color | tr '[:upper:]' '[:lower:]') in
        black) color=0 ;;
        red) color=1 ;;
        green) color=2 ;;
        yellow) color=3 ;;
        blue) color=4 ;;
        magenta) color=5 ;;
        cyan) color=6 ;;
        white|*) color=7 ;; # white or invalid color
       esac
    fi
    tput bold;
    tput setaf "$color";
    printf "%s %s\n" "$arrow" "$exp";
    tput sgr0;
}

info() {
    coloredEcho "$1" blue "===>"
}

success() {
    coloredEcho "$1" green "===>"
}

error() {
    coloredEcho "$1" red "===>"
}

substep_info() {
    coloredEcho "$1" magenta "======"
}

substep_success() {
    coloredEcho "$1" cyan "======"
}

substep_error() {
    coloredEcho "$1" red "======"
}

ask_user() {
	coloredEcho "$1" magenta "---------> "
}

ask_sudo() {
        info "Asking for the administrator password upfront..."
        if sudo -v; then
                # Keep-alive: update existing `sudo` time stamp until `setup.sh` has finished
                while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
                success "Sudo credentials updated."
        else
                error "Failed to get sudo credentials."
        fi
}

