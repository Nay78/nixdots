{ pkgs, unstable, ... }:
{
  environment.systemPackages = with pkgs; [
    # terminals
    alacritty
    kitty
    foot
    unstable.warp-terminal

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
    cargo
    unzip
    ripgrep
    nixfmt-rfc-style
    cmake

    # go

    go
    unstable.gomobile

    # terminal and tools
    tmux # multiplexer
    sesh
    zoxide
    fzf
    sshs
    atac
    termshark

    dvtm # terminal multiplexer
    abduco # terminal sessions
  ];
}
