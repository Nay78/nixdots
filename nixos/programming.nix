{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    alacritty
    kitty
    foot

    helix
    zsh
    stow
    grim
    git
    pkgs.libinput
    # libnotify # dunst depends on this
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    gnumake
    pkgs.libgcc
    gcc
    nodejs
    go
    cargo
    unzip
    ripgrep
    nixfmt-rfc-style
    cmake
  ];
}
