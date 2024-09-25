alias mystow='stow -d ~/nixos/home/dotfiles -t ~/ .'
alias rebuild='sudo nixos-rebuild switch --flake ~/nixos && stow -d ~/nixos/home/dotfiles -t ~/ .'
alias testb='sudo nixos-rebuild test --flake ~/nixos'
alias restart_audio='systemctl --user restart wireplumber pipewire pipewire-pulse'

alias cennvpn='openconnect --protocol=anyconnect --usergroup=Nomina authgroup=Nomina useragent="AnyConnect-compatible OpenConnect VPN agent" --user=jejlvalenzuelaa vpn.aminerals.cl'
alias cennvpn1='openconnect --protocol=anyconnect --usergroup=Nomina authgroup=Nomina useragent="AnyConnect-compatible OpenConnect VPN agent" --user=jejlvalenzuelaa vpn.aminerals.cl'
alias cennvpn2='openconnect --protocol=anyconnect --usergroup=Nomina --user=jejlvalenzuelaa vpn.aminerals.cl'
