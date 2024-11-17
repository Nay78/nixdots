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
    # unstable.gomobile

    # kotlin
    kotlin
    kotlin-native
    jetbrains.idea-community
    gradle
    jdk
    unstable.android-studio

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

    # libs
    glib
    glibc
    nss
    gobject-introspection
    # libxcb
    #   libxcomposite
    #   libxcursor
    #   libxdamage
    #   libxrandr
  ];
}
