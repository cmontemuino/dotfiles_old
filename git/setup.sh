#!/usr/bin/env bash

declare -r DIR="$(dirname "$0")"
cd "$DIR"

. ../hacks/functions.sh

set -e

declare -r SOURCE="$(realpath -m .)"
declare -r DESTINATION="$(realpath -m ~)"

setup_gitconfig() {
	if ! [[ -f .gitconfig.symlink ]]; then
		substep_info "local .gitconfig file does not exist yet. Configuring it now."

		ask_user "What is your GPG key used for signing commits?"
		# -e: use readline to obtain the line in an interactive shell
		# -r: don't allow backslashes to escape any characters
		# -t: timeout in seconds
		read -e -r -t 60

		sed -e "s/GPG_SIGNING_KEY/$REPLY/g" .gitconfig.local > .gitconfig.symlink

		substep_success ".gitconfig.symlink file is ready for use."
	else
		substep_success ".gitconfig.symlink file does exist already. There's nothing to be done. Delete it if you want to generate it again."
	fi
}

symlink_files() {
	find . -name "*.symlink" | while read fn; do
	    fn="$(basename $fn)"
	    # make sure to remove the ".symlink" extention to destination file
	    symlink "$SOURCE/$fn" "$DESTINATION/${fn%.*}"
	done

}

info "Configuring a local .gitconfig file ..."
setup_gitconfig

info "Symlinking git files ..."
symlink_files

success "Finished configuring git."
