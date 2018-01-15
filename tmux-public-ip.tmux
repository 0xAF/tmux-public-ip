#!/usr/bin/env bash
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

do_interpolation() {
	local interpolated="${1/\#\{public_ip\}/\#($CURRENT_DIR/scripts/public_ip.sh)}"
	echo "$interpolated"
}

update_tmux_option() {
	tmux set-option -gq "$1" "$(do_interpolation "$(tmux show-option -gqv "$1")")"
}

main() {
	update_tmux_option "status-right"
	update_tmux_option "status-left"
}
main

