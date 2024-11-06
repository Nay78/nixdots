# ~~~~~~~~~~~ PATH ~~~~~~~~~~~~~~~
export PATH="$PATH:~/.config/lf/scripts"
export PATH=~/.local/scripts:$PATH

# ~~~~~~~~~~~ Variables ~~~~~~~~~~~~~~~
export VISUAL=nvim
export EDITOR=nvim
export BROWSER="qutebrowser"

# config
export HISTSIZE=25000
export SAVEHIST=25000

# directories
# export REPOS="$HOME/Repos"
export GITUSER="alejg"
# export DOTFILES="$GHREPOS/dotfiles"
# export LAB="$GHREPOS/lab"
# export SCRIPTS="$DOTFILES/scripts"
# export ICLOUD="$HOME/icloud"
export ZETTELKASTEN="$HOME/zet"

# Go related. In general all executables and scripts go in .local/bin
# export GOBIN="$HOME/.local/bin"

# export GOPATH="$HOME/.local/share/go"
# export GOPATH="$HOME/go/"

export DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=true

# ssh
# ssh-add -q ~/.ssh/id_ed25519

# ~~~~~~~~~~~ nav aliases ~~~~~~~~~~~~~~~
# alias sha='echo -n 'foobargcc' |openssl dgst -sha256'
alias ll='ls -la'
alias ..="cd .."
alias c="clear"
alias t='tmux'
alias e='exit'
alias f='fzf'
alias mountx='gocryptfs ~/files/alejg ~/Desktop/alejg'

# personal

alias nix-clean='sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +5 && nix-store --gc'
alias reb='sudo nixos-rebuild switch --verbose --flake ~/nixos && stow -d ~/nixos/home/dotfiles -t ~/ .'
alias reb2='sudo nixos-rebuild switch --verbose --commit-lock-file --flake ~/nixos && stow -d ~/nixos/home/dotfiles -t ~/ .'
alias nixlog="journalctl -u home-manager-alejg.service"
# alias gsync='rclone sync ~/files/ drive:files'
alias backup='rclone sync ~/files/ drive:backup/files'
alias mystow='stow -d ~/nixos/home/dotfiles -t ~/ .'
# alias stowsecrets='sudo stow -d ~/nixos/secrets/root -t / .'
alias stowsecrets='[ -d ~/nixos/secrets/root ] && sudo stow -d ~/nixos/secrets/root -t / . || echo "Folder ~/nixos/secrets/root does not exist."'

alias testb='sudo nixos-rebuild test --flake ~/nixos'
alias restart_audio='systemctl --user restart wireplumber pipewire pipewire-pulse'
alias mysync="rclone sync ~/Desktop/orlando drive:backup/orlando"
alias mysync2="rclone sync ~/nixos drive:backup/nixos"

# projects
alias p-nix='cd ~/nixos && nvim'
alias p-zet='cd $ZETTELKASTEN && nvim'
# alias cennvpn='openconnect --protocol=anyconnect --usergroup=Nomina authgroup=Nomina useragent="AnyConnect-compatible OpenConnect VPN agent" --user=jejlvalenzuelaa vpn.aminerals.cl'
# alias cennvpn1='openconnect --protocol=anyconnect --usergroup=Nomina authgroup=Nomina useragent="AnyConnect-compatible OpenConnect VPN agent" --user=jejlvalenzuelaa vpn.aminerals.cl'
# alias cennvpn2='openconnect --protocol=anyconnect --usergroup=Nomina --user=jejlvalenzuelaa vpn.aminerals.cl'

# ~~~~~~~~~~~ prompt ~~~~~~~~~~~~~~~
eval "$(starship init bash)"
eval "$(zoxide init bash)"

# ~~~~~~~~~~~ binds ~~~~~~~~~~~~~~~
bind '"\C-o":"\C-u y\C-m"'

# ~~~~~~~~~~~ Functions ~~~~~~~~~~~~~~~
function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}
