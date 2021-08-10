#!/usr/bin/env bash

DIR="$(dirname "$0")"
cd "$DIR"

. ../hacks/functions.sh

SOURCE="$(realpath -m .)"
DESTINATION="$(realpath -m ~)"

info "Configuring git..."

find . -name ".git*" | while read fn; do
    fn="$(basename $fn)"
    symlink "$SOURCE/$fn" "$DESTINATION/$fn"
done

success "Finished configuring git."
