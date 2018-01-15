# Tmux public IP

Tmux plugin that enables displaying of your public IP address in your status line.

The plugin will add new `#{public_ip}` format, which you can use in `status-left` or `status-right`.

Quick test:

    set -g status-right "IP: #{public_ip} | %a %h-%d %H:%M "

### Installation with [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm) (recommended)

Add plugin to the list of TPM plugins in `.tmux.conf`:

    set -g @plugin '0xAF/tmux-public-ip'

Hit `prefix + I` to fetch the plugin and source it.

`#{online_status}` interpolation should now work.

### Manual Installation

Clone the repo:

    $ git clone https://github.com/0xAF/tmux-public-ip ~/clone/path

Add this line to the bottom of `.tmux.conf`:

    run-shell ~/clone/path/tmux-public-ip.tmux

Reload TMUX environment:

    # type this in terminal
    $ tmux source-file ~/.tmux.conf

`#{public_ip}` interpolation should now work.

### Limitations

The script will check for your public IP address on 60 seconds interval by default
If you want to change this, see the `scripts/public_ip.sh` file.

### License

[WTFPL](LICENSE)
