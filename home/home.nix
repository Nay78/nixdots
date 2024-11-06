{
  pkgs,
  unstable,
  config,
  ...
}@inputs:
let
  inherit (import ../variables.nix) secondDriveMnt;
in
{
  imports = [
    # ./modules/nnn
    # ./modules/wezterm.nix
    ./modules/golang.nix
    ./modules/wayland/sway.nix
    ./modules/wayland/hyprland.nix
    ./modules/nvim.nix
    # ./modules/python.nix
    # ./modules/gbar.nix
    # ./modules/wezterm.nix
    # ./modules/helix.nix
  ];

  programs.home-manager.enable = true;
  programs.fish.enable = true;
  home.stateVersion = "24.05";
  # home.homeDirectory = "/home/alejg"
  # dowload folder in second drive

  # home.file."Downloads".source = config.lib.file.mkOutOfStoreSymlink "${secondDriveMnt}/Downloads";
  # home.file."Downloads" = {
  #   source = "${secondDriveMnt}/Downloads";
  #   target = "~/Downloads";
  # };

  home.packages = with pkgs; [
    usbutils
    # stig # bittorrent
    exfat
    util-linux
    nemo
    qbittorrent
    unstable.vscode
    # for ai assistant
    portaudio
    unstable.cudaPackages.cuda_nvcc
    unstable.ollama-cuda
    zip
    entr
    openssl
    gocryptfs
    rclone
    p7zip
    # icu
    # pmount
    qemu
    quickemu
    libsForQt5.dolphin
    qalculate-gtk
    yt-dlp # tools
    feh # image viewer
    zathura # pdf viewer
    wireguard-tools # vpn
    openconnect # vpn
    xorg.xev # tools
    vifm-full
    # nvd # nix diffs
    nix-visualize

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
    gimp
    vlc
    mpv
    # (inkscape-with-extensions.override {
    #   inkscapeExtensions = [ inkscape-extensions.applytransforms ];
    # })
    obs-studio
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

    unstable.dbeaver-bin
    unstable.insomnia

    # sway modules
    swayidle
    wl-clipboard
    grim # screenshot
    slurp # screenshot

    libnotify

    # preview Markdown

    anki-bin

    docker-compose
    gtypist

    vial
    qmk
    via
    keepassxc
    # unstable.dropbox
    krita
    # Nvidia stuff. FIXME: fine tune for the new hardware

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
    poetry
    pipx
    uv
    (unstable.python3.withPackages (
      ps: with ps; [
        requests
        pandas
        numpy
        ipython
        attrs
        cattrs
        click
        colorama
        pyyaml
        keyutils
        pynacl # qute-keepassxc
        grip

        evdev
        pyaudio
        "git+https://github.com/stlukey/whispercpp.py"
        pip
        # llama-assistant
        # llama-assistant
        # PyQt5
        # SpeechRecognition
        markdown
        pynput
        # llama-cpp-python
        # huggingface_hub
        # openwakeword
        # pyinstaller
        ffmpeg-python
        "git+https://github.com/vietanhdev/llama-assistant"
      ]
    ))

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

  xdg.mimeApps = {
    enable = true;
    associations.added = {
      "application/pdf" = [ "zathura.desktop" ];
    };
    defaultApplications = {
      # "inode/directory" = [ "pcmanfm.desktop" ]; # Directories
      # "text/plain" = [ "emacsclient.desktop" ]; # Plain text
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = [
        "onlyoffice-desktopeditors.desktop"
      ]; # .docx
      "application/vnd.openxmlformats-officedocument.presentationml.presentation" = [
        "onlyoffice-desktopeditors.desktop"
      ]; # .pptx
      "application/pdf" = [ "zathura.desktop" ]; # .pdf
      "application/zip" = [ "xarchiver.desktop" ];
      "text/*" = [ "emacsclient.desktop" ]; # Any text files
      "video/*" = [ "mpv.desktop" ]; # Any video files
      "x-scheme-handler/unknown" = [ "org.qutebrowser.qutebrowser.desktop" ]; # Links
      "x-scheme-handler/about" = [ "org.qutebrowser.qutebrowser.desktop" ]; # Links
      "x-scheme-handler/https" = [ "org.qutebrowser.qutebrowser.desktop" ]; # Links
      "x-scheme-handler/http" = [ "org.qutebrowser.qutebrowser.desktop" ]; # Links
      "x-scheme-handler/mailto" = [ "org.qutebrowser.qutebrowser.desktop" ]; # Links
      "image/*" = [ "feh.desktop" ]; # Images
      "image/webp" = [ "feh.desktop" ]; # Images
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

  programs.lazygit.enable = true;
  programs.gh.enable = true;

}
