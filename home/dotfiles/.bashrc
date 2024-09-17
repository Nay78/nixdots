alias mystow='stow -d ~/nixos/home/dotfiles -t ~/ .'
alias rebuild='sudo nixos-rebuild switch --flake ~/nixos && stow -d ~/nixos/home/dotfiles -t ~/ .'
alias testb='sudo nixos-rebuild test --flake ~/nixos'
