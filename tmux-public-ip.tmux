#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PLUGIN_DIR="$CURRENT_DIR" # required by scripts/helpers.sh

source "$CURRENT_DIR/scripts/helpers.sh"

interpolate() {
	local interpolated="$1"
	echo "$interpolated" |  sed -e "s|#{public_ip\([^}]*\)}|#(sh $CURRENT_DIR/scripts/public_ip.sh \1)|g"
}


update_status_option() {
	local option="$1"
	local option_value="$(get_tmux_option "$option")"
	set_tmux_option "$option" "$(interpolate "$option_value")"
}

main() {
	set_tmux_option "@public_ip_plugin_dir" "$CURRENT_DIR"
	update_status_option "status-right"
	update_status_option "status-left"
}
main

