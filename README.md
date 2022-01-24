# Tmux Public IP Plugin

Shows your **Public IP** address and/or other data (like **Country**, **City**, **GPS Coordinates**, **ISP**, etc.), provided in JSON format by [ifconfig.co](https://ifconfig.co/json) and [ipinfo.io](https://ipinfo.io/json) and others.

The plugin will add new `#{public_ip}` format, which you can use in `status-left` or `status-right`.

You can add the JSON key as parameter. Default is '**ip**'.

### Example:

    set -g status-right "IP: #{public_ip} | Country #{public_ip country} | #{public_ip city} | %a %h-%d %H:%M "

Check out [ifconfig.co JSON output](https://ifconfig.co/json) (or your provider's JSON) for possible parameters.


### Plugin Configuration:
| param | description | default |
| --- | --- | --- |
| **@public_ip_dir** | Temp dir to store JSON cache file | ~/.tmux/public_ip.tmp |
| **@public_ip_tmp_file** | Temp file for JSON data (saved in temp dir) | info.json |
| **@public_ip_json_url** | URL for JSON data | https://ifconfig.co/json |
| **@public_ip_refresh_seconds** | Time before refreshing the data. Most providers will ban you if you refresh more than once in a minute | 60 |

Example configuration:

    set -g @public_ip_dir '/tmp'
    set -g @public_ip_tmp_file 'tmux-pip.json'
    set -g @public_ip_json_url 'https://ipinfo.io/json'
    set -g @public_ip_refresh '120'


---



### Installation with [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm) (recommended)

Add plugin to the list of TPM plugins in `.tmux.conf`:

    set -g @plugin '0xAF/tmux-public-ip'

Hit `prefix + I` to fetch the plugin and source it.

`#{public_ip}` interpolation should now work.

### Manual Installation

Clone the repo:

    $ git clone https://github.com/0xAF/tmux-public-ip ~/clone/path

Add this line to the bottom of `.tmux.conf`:

    run-shell ~/clone/path/tmux-public-ip.tmux

Reload TMUX environment:

    # type this in terminal
    $ tmux source-file ~/.tmux.conf

`#{public_ip}` interpolation should now work.

### License

[WTFPL](LICENSE)
