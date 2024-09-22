# credit: HOFSIEDGE
{
  pkgs,
  lib,
  unstable,
  self,
  ...
}@inputs:
{
  imports = [
    ./modules/nnn
    # ./modules/helix
    ./modules/wezterm.nix

    ./modules/golang.nix

    # ./modules/wezterm.nix
    #    ./modules/helix.nix

  ];

  #  home-manager.users.barroco = {
  #   services.sxhkd = {
  #     enable = true;
  #     keybindings = {
  #       "super + space" = "rofi -show run";
  #       "super + Return" = "alacritty";
  #     };
  #   };
  # };

  programs.home-manager.enable = true;
  home.stateVersion = "24.05";
  # home.homeDirectory = "/home/alejg"

  # home.file.".bashrc".source = ./dotfiles/.bashrc;
  # home.file.".inputrc".source = ./dotfiles/.inputrc;
  #
  # home.file.".config/nvim" = {
  #   source = ./dotfiles/nvim;
  #   recursive = true;
  # };
  # add unstable and tree-sitter-idris to submodule arguments
  # _module.args = {
  #   inherit (inputs) unstable tree-sitter-idris;
  # };

  custom = {
    nnn.enable = true;
  };

  home.packages =
    with pkgs;
    # assert unstable.fluffychat.meta.insecure || throw "fluffychat is secure now! enable it!";
    [

      tmux
      waybar
      helix
      wireguard-tools # tools
      openconnect # tools
      lf
      xorg.xev
      vifm-full
      wezterm
      # nvd # nix diffs
      nix-visualize

      # nekoray

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
      # sound & display controls
      # TODO: use a graph instead (https://github.com/futpib/pagraphcontrol)
      # TODO: add effects (https://github.com/wwmm/easyeffects)
      pavucontrol
      # pulseaudio
      playerctl
      brightnessctl

      (unstable.python312.withPackages (
        ps: with ps; [
          requests
          ipython
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
      unstable.dropbox
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

  # TODO: swaylock, swayidle, ly display manager
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    config = rec {
      bars = [ { command = "waybar"; } ];
      terminal = "alacritty";
      modifier = "Mod4";
      # menu = "${pkgs.fuzzel}/bin/fuzzel";
      menu = "${pkgs.rofi}/bin/rofi -show combi";
      keybindings = lib.mkOptionDefault {
        # Brightness
        XF86MonBrightnessDown = ''exec "brightnessctl set 5%-"'';
        XF86MonBrightnessUp = ''exec "brightnessctl set +5%"'';

        # Volume
        XF86AudioRaiseVolume = ''exec "wpctl set-volume @DEFAULT_SINK@ 0.02+"'';
        XF86AudioLowerVolume = ''exec "wpctl set-volume @DEFAULT_SINK@ 0.02-"'';
        XF86AudioMute = ''exec "wpctl set-mute @DEFAULT_SINK@ toggle"'';
        XF86AudioNext = ''exec "playerctl next"'';
        XF86AudioPrev = ''exec "playerctl previous"'';
        XF86AudioPlay = ''exec "playerctl play-pause"'';

        # Screenshot
        Print = ''exec grim -g "$(slurp)" /tmp/$(date +'%H:%M:%S.png')'';
        "Ctrl+Print" = "exec ocr-screenshot";
        # Password manager

        "${modifier}+p" = "exec keepassxc";

        # power
        XF86PowerOff = "exec systemctl suspend";
      };

      input = {
        # Keyboard
        "*" = {
          xkb_layout = "us";
          # xkb_options = "grp:alt_shift_toggle";
          repeat_delay = "200";
          repeat_rate = "65";
        };
        "1:1:AT_Translated_Set_2_keyboard" = {
          repeat_delay = "100";
          repeat_rate = "65";
          xkb_numlock = "enable";

        };
        "type:touchpad" = {
          tap = "enabled";
          natural_scroll = "enabled";
          scroll_factor = "0.5";
          dwt = "disabled";
        };
        # TODO
        # "1386:890:Wacom_One_by_Wacom_S_Pen" = { };
      };
    };
    # extraOptions = [ "--unsupported-gpu" ];
    # TODO: migrate to config
    # extraConfig = ''
    #   # HDMI workspace 9
    #   workspace 9 output HDMI-A-1
    # '';
  };

  # programs.helix = {
  #   enable = true;
  #   settings = {
  #     theme = "autumn_night_transparent";
  #     editor.cursor-shape = {
  #       normal = "block";
  #       insert = "bar";
  #       select = "underline";
  #     };
  #   };
  #   languages.language = [
  #     {
  #       name = "nix";
  #       auto-format = true;
  #       formatter.command = "${pkgs.nixfmt}/bin/nixfmt";
  #     }
  #   ];
  #   themes = {
  #     autumn_night_transparent = {
  #       "inherits" = "autumn_night";
  #       "ui.background" = { };
  #     };
  #   };
  # };

  programs.fuzzel = {
    enable = true;
    settings.main.dpi-aware = lib.mkForce true;
  };

  # programs.lf = {
  #   enable = true;
  #   settings = {
  #     preview = true;
  #     hidden = true;
  #     drawbox = true;
  #     icons = true;
  #     ignorecase = true;
  #   };
  # };

  programs.swaylock.enable = true;
  services.mako.enable = true; # notifications
  gtk.enable = true;

  # programs.wezterm = {
  #   enable = true;
  #   extraConfig = ''
  #       local wezterm = require 'wezterm'
  #       return {
  #         enable_tab_bar = true,
  #         front_end = "WebGpu", 
  #         color_scheme = "MaterialDesignColors",
  #
  #         font = wezterm.font_with_fallback {
  #            'JetBrains Mono',
  #            'FreeMono',
  #         },
  #       window_padding = {
  #            left = 0,
  #            right = 0,
  #            top = 0,
  #            bottom = 0,
  #       },
  #       hide_tab_bar_if_only_one_tab = false,
  #     }
  #   '';
  # };

  # programs.lazygit.enable = true;

  # programs.firefox = {
  #   enable = true;
  #   package = unstable.firefox-devedition-bin;
  #   profiles = rec {
  #     alejg = {
  #       id = 0;
  #       search = {
  #         engines = {
  #           "Bing".metaData.hidden = true;
  #           # "Google".metaData.alias = "@g";
  #         };
  #         force = true;
  #       };
  #     };
  #     # dev-edition-default = hofsiedge // {
  #     #   id = 1;
  #     # };
  #   };
  # };

  # programs.nushell = {
  #   enable = true;
  #   configFile.text = ''
  #   '';
  #   environmentVariables = {
  #     EDITOR = "hx";
  #   };
  # };

  # for those use cases where helix is lacking yet
  # programs.vscode = {
  #   enable = false;
  #   package = pkgs.vscodium;
  #   extensions =
  #     with pkgs.vscode-extensions;
  #     [ golang.go ]
  #     ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
  #       {
  #         name = "idris-vscode";
  #         publisher = "meraymond";
  #         version = "latest";
  #         # sha256 = pkgs.lib.fakeHash;
  #         sha256 = "sha256-QAzjm+8Z+4TDbM5amh3UEkSmp0n8ZlRHYpUGAewIVXk=";
  #       }
  #       {
  #         name = "templ";
  #         publisher = "a-h";
  #         version = "latest";
  #         # sha256 = pkgs.lib.fakeHash;
  #         sha256 = "sha256-/77IO+WjgWahUrj6xVl0tkvICh9Cy+MtfH2dewxH8LE=";
  #       }
  #     ];
  #
  #   userSettings = {
  #     "python.defaultInterpreterPath" = "/run/current-system/sw/bin/python";
  #     "idris.idrisPath" = "idris2";
  #   };
  # };
  #
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
  #   xdg.mimeApps = {
  #     enable = true;
  #     defaultApplications =
  #       with pkgs.lib.attrsets;
  #       concatMapAttrs (name: mimes: genAttrs mimes (_: name + ".desktop")) {
  #         "firefox-developer-edition" = [
  #           "application/pdf"
  #           "x-scheme-handler/http"
  #           "x-scheme-handler/https"
  #           "text/html"
  #           "application/xhtml+xml"
  #           "x-scheme-handler/chrome"
  #           "application/x-extension-htm"
  #           "application/x-extension-html"
  #           "application/x-extension-shtml"
  #           "application/x-extension-xhtml"
  #           "application/x-extension-xht"
  #         ];
  #         "org.telegram.desktop" = [ "x-scheme-handler/tg" ];
  #       };
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
}
