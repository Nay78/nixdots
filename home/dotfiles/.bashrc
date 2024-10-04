alias mystow='stow -d ~/nixos/home/dotfiles -t ~/ .'
alias rebuild='sudo nixos-rebuild switch --flake ~/nixos && stow -d ~/nixos/home/dotfiles -t ~/ .'
alias testb='sudo nixos-rebuild test --flake ~/nixos'
alias restart_audio='systemctl --user restart wireplumber pipewire pipewire-pulse'

alias cennvpn='openconnect --protocol=anyconnect --usergroup=Nomina authgroup=Nomina useragent="AnyConnect-compatible OpenConnect VPN agent" --user=jejlvalenzuelaa vpn.aminerals.cl'
alias cennvpn1='openconnect --protocol=anyconnect --usergroup=Nomina authgroup=Nomina useragent="AnyConnect-compatible OpenConnect VPN agent" --user=jejlvalenzuelaa vpn.aminerals.cl'
alias cennvpn2='openconnect --protocol=anyconnect --usergroup=Nomina --user=jejlvalenzuelaa vpn.aminerals.cl'

lfcd() {
  # `command` is needed in case `lfcd` is aliased to `lf`
  cd "$(command lf -print-last-dir "$@")"
}
bind '"\C-o":"lfcd\C-m"'

lf() {
  LF_TEMPDIR="$(mktemp -d -t lf-tempdir-XXXXXX)"
  LF_TEMPDIR="$LF_TEMPDIR" lf-run -last-dir-path="$LF_TEMPDIR/lastdir" "$@"
  if [ "$(cat "$LF_TEMPDIR/cdtolastdir" 2>/dev/null)" = "1" ]; then
    cd "$(cat "$LF_TEMPDIR/lastdir")"
  fi
  rm -r "$LF_TEMPDIR"
  unset LF_TEMPDIR
}

export PATH="$PATH:~/.config/lf/scripts"
