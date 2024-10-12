{
  pkgs,
  lib,
  unstable,
  self,
  ...
}@inputs:
# let
#       inherit (import ../variables.nix) hostname system username;
# in
{
  imports = [
    # ./modules/nnn
    # ./modules/wezterm.nix
    ./modules/golang.nix
    ./modules/wayland/sway.nix
    ./modules/wayland/hyprland.nix
    ./modules/nvim.nix
    # ./modules/gbar.nix
    # ./modules/wezterm.nix
    # ./modules/helix.nix
  ];

  programs.home-manager.enable = true;
  programs.fish.enable = true;
  home.stateVersion = "24.05";
  # home.homeDirectory = "/home/alejg"

  home.packages = with pkgs; [

    # icu
    # pmount
    udisks
    udiskie
    zoxide
    qemu
    libsForQt5.dolphin
    qalculate-gtk
    yt-dlp
    feh
    zathura
    tmux
    wireguard-tools # tools
    openconnect # tools
    xorg.xev
    vifm-full
    # nvd # nix diffs
    nix-visualize

    # file manager and utils
    yazi
    poppler
    lf
    ffmpeg
    ghostscript
    imagemagick
    ueberzug

    # nekoray
    starship

    chromium
    firefox
    unstable.vivaldi
    qutebrowser
    unstable.google-chrome
    # unstable.telegram-desktop
    # deluge
    # thunderbird
    # freerdp
    # remmina

    # nixops

    libreoffice-fresh

    # media
    krita
    # (blender.override { cudaSupport = true; }) mpv
    vlc
    mpv
    # (inkscape-with-extensions.override {
    #   inkscapeExtensions = [ inkscape-extensions.applytransforms ];
    # })
    obs-studio
    # godot_4
    # kdenlive
    # kicad
    # freecad
    # okular
    # typst
    htop-vim

    pdfcpu

    # zettlr
    # sound & display ccontrols
    # TODO: use a graph instead (https://github.com/futpib/pagraphcontrol)
    # TODO: add effects (https://github.com/wwmm/easyeffects)
    # pavucontrol
    # pulseaudio
    # brightnessctl

    (unstable.python312.withPackages (
      ps: with ps; [
        requests
        ipython
        attrs
        cattrs
        click
        colorama
        pyyaml
        keyutils
      ]
    ))

    unstable.dbeaver-bin
    unstable.insomnia

    # sway modules
    swayidle
    wl-clipboard
    grim # screenshot
    slurp # screenshot

    libnotify

    # preview Markdown
    python312Packages.grip

    anki-bin

    # leafpad
    # gotop
    # tree
    # cloc
    # jq
    # superfile

    docker-compose

    gtypist

    vial
    qmk
    via
    keepassxc
    # unstable.dropbox
    krita
    # Nvidia stuff. FIXME: fine tune for the new hardware
    # egl-wayland

    # development
    avra
    avrdude
    pkgsCross.avr.buildPackages.gcc
    # pass-wayland

    # unstable.anydesk

    # FIXME: this should be a shell within nix store on build.
    # (pkgs.writeShellScriptBin "go-playground" ''
    #   cd $HOME/Projects/misc/go-playground
    #   nix develop --offline --command $EDITOR code.go
    # '')

    (pkgs.writeShellApplication {
      name = "ocr-screenshot";
      runtimeInputs = with pkgs; [
        grim
        slurp
        tesseract
        wl-clipboard
        libnotify
      ];
      text = ''
        grim -g "$(slurp)" /tmp/ocr.png \
        && tesseract \
          -c preserve_interword_spaces=1 "$@" /tmp/ocr.png stdout \
          -l eng+rus+deu+jpn \
        |  wl-copy \
        && notify-send \
          --expire-time 5000 \
          --urgency low \
          "OCR complete" \
          "Result copied to the clipboard"
      '';
    })
  ];

  xdg.desktopEntries.ocr = {
    name = "OCR image";
    exec = "${pkgs.writeScript "ocr" ''
      ${pkgs.xfce.xfce4-screenshooter}/bin/xfce4-screenshooter -r --save /tmp/ocr-tmp.png
      ${pkgs.tesseract}/bin/tesseract /tmp/ocr-tmp.png /tmp/ocr-out
      cat /tmp/ocr-out.txt | ${pkgs.xclip}/bin/xclip -sel clip
      rm /tmp/ocr-tmp.png
    ''}";
  };

  programs.lazygit.enable = true;

  xdg.mimeApps = {
    enable = true;
    associations.added = {
      "application/pdf" = [ "zathura.desktop" ];
    };
    defaultApplications = {
      "inode/directory" = [ "pcmanfm.desktop" ]; # Directories
      # "text/plain" = [ "emacsclient.desktop" ]; # Plain text
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = [
        "onlyoffice-desktopeditors.desktop"
      ]; # .docx
      "application/vnd.openxmlformats-officedocument.presentationml.presentation" = [
        "onlyoffice-desktopeditors.desktop"
      ]; # .pptx
      "application/pdf" = [ "onlyoffice-desktopeditors.desktop" ]; # .pdf
      "application/zip" = [ "xarchiver.desktop" ];
      "text/*" = [ "emacsclient.desktop" ]; # Any text files
      "video/*" = [ "mpv.desktop" ]; # Any video files
      "x-scheme-handler/https" = [ "firefox.desktop" ]; # Links
      "x-scheme-handler/http" = [ "firefox.desktop" ]; # Links
      "x-scheme-handler/mailto" = [ "firefox.desktop" ]; # Links
      "image/*" = [ "feh.desktop" ]; # Images
      "image/png" = [ "feh.desktop" ];
      "image/jpeg" = [ "feh.desktop" ];

    };
  };

  programs.git = {
    enable = true;
    userName = "alejg";
    userEmail = "nayguel.martinez@gmail.com";
    ignores = [
      "*.swp"
      "*.bin"
      "*.pyc"
      "__pycache__"
      "node_modules"
      ".nix_node"
      ".nix_go"
    ];
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
  #   programs.gh.enable = true;
  #
  #   programs.bash = {
  #     enable = true;
  #     bashrcExtra = ''
  #       export XDG_DATA_HOME="$HOME/.local/share"
  #       export PS1="\n(''${name:-sys-env}) \[\033[1;32m\][\[\e]0;\u@\h: \w\a\]\u@\h:\w]\n\$\[\033[0m\] "
  #     '';
  #   };
  #
  #

  # programs.tmux = {
  #   enable = true;
  #   clock24 = true;
  #   extraconfig = ''
  #     # used for less common options, intelligently combines if defined in multiple places.
  #        # ...
  #   '';
  # };
  # programs.yazi = {
  #   enable = true;
  #   enablebashintegration = true;
  # };
  #   };

  # custom = {
  #   nnn.enable = true;
  # };
}
