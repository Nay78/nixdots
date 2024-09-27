{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    helix
    zsh
    alacritty
    stow
    grim
    mako
    git
    pkgs.libinput
    #pkgs.waybar
    #pkgs.dunst
    libnotify # dunst depends on this
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
  ];
}
