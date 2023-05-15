PLUGIN_DIR=$(tmux show-option -gqv "@public_ip_plugin_dir")
source "$PLUGIN_DIR/scripts/helpers.sh"

pip_dir_default="$PLUGIN_DIR/../../public_ip.tmp"
pip_dir_option="@public_ip_dir"

pip_tmp_file_default="info.json"
pip_tmp_file_option="@public_ip_tmp_file"

pip_json_url_default="https://ifconfig.co/json"
pip_json_url_option="@public_ip_json_url"

pip_refresh_default="60"
pip_refresh_option="@public_ip_refresh_seconds"

pip_dir() {
	if [ -z "$_PIP_DIR" ]; then
		local path="$(get_tmux_option "$pip_dir_option" "$pip_dir_default")"
		# expands tilde, $HOME
		echo "$path" | sed "s,\$HOME,$HOME,g; s,\~,$HOME,g"
	else
		echo "$_PIP_DIR"
	fi
}
_PIP_DIR="$(pip_dir)"

pip_tmp_file() {
	if [ -z "$_PIP_TMP_FILE" ]; then
		local path="$(get_tmux_option "$pip_tmp_file_option" "$pip_tmp_file_default")"
		# expands tilde, $HOME
		echo "$path" | sed "s,\$HOME,$HOME,g; s,\~,$HOME,g"
	else
		echo "$_PIP_TMP_FILE"
	fi
}
_PIP_TMP_FILE="$(pip_tmp_file)"

pip_url() {
	if [ -z "$_PIP_URL" ]; then
		get_tmux_option "$pip_json_url_option" "$pip_json_url_default"
	else
		echo "$_PIP_URL"
	fi
}
_PIP_URL="$(pip_url)"

pip_refresh() {
	if [ -z "$_PIP_REFRESH" ]; then
		get_tmux_option "$pip_refresh_option" "$pip_refresh_default"
	else
		echo "$_PIP_REFRESH"
	fi
}
_PIP_REFRESH="$(pip_refresh)"


public_ip_helper() {
	local key="${1:-ip}"
	local cache="$(pip_dir)/$(pip_tmp_file)"
	local refresh=$(pip_refresh)
	mkdir -p "$(pip_dir)"

	# if cache file is missing or is older than 60 seconds, then refresh
	if is_osx; then
		if [[ ! -f "$cache" || $(( $(date +%s) - $(stat -t %s -f %m -- "$cache") )) -gt $refresh ]]; then
			curl -s "$_PIP_URL" -o "$cache"
		fi
	else
		if [[ ! -f "$cache" || $(( $(date +%s) - $(stat -L --format %Y "$cache") )) -gt $refresh ]]; then
			curl -s "$_PIP_URL" -o "$cache"
		fi
	fi

	grep -o "\"$key\": \"[^\"]*" "$cache" | grep -o '[^"]*$'
}

public_ip_helper $*

