# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (import ./variables.nix)
    hostname
    system
    username
    secondDriveMnt
    ;
in
{
  imports = [
    ./hardware-configuration.nix
    ./nixos/vbox.nix
    ./nixos/qutebrowser-profiles.nix
    ./nixos/dropbox.nix
    # ./nixos/vfio.nix
    # ./nixos/sddm.nix
  ];

  # services.thermald.enable = true;
  nixpkgs.config.allowUnfree = true;
  services.auto-cpufreq.enable = true;

  services.udev.extraRules = ''
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{serial}=="*vial:f64c2b3c*", MODE="0660", GROUP="100", TAG+="uaccess", TAG+="udev-acl"
    KERNEL=="hidraw*", MODE="0766"
    # ACTION=="add", SUBSYSTEMS=="usb", SUBSYSTEM=="block", ENV{ID_FS_USAGE}=="filesystem", RUN{program}+="${pkgs.systemd}/bin/systemd-mount --no-block --automount=yes --collect --options=rw,uid=${username} $devnode /media/$(basename $devnode)"
    ACTION=="add", SUBSYSTEMS=="usb", SUBSYSTEM=="block", ENV{ID_FS_USAGE}=="filesystem", RUN{program}+="${pkgs.systemd}/bin/systemd-mount --no-block --automount=yes --collect --options=rw,uid=${username} $devnode /media/$devnode"
  '';

  nix = {
    package = pkgs.nixVersions.stable;
    # package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
    };
    nix-ld = {
      enable = true;
    };
    # lutris.enable = true;
  };

  systemd.user.services.stow = {
    description = "Stow Download folder on second drive";
    after = [ "graphical.target" ]; # or "default.target", depending on your session manager
    wantedBy = [ "default.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "ln -s ${secondDriveMnt}/Downloads ~/";
      RemainAfterExit = true;
    };
  };

  environment.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
    # QT_SCALE_FACTOR = "1.1";
    QT_SCALE_FACTOR_ROUNDING_POLICY = "RoundPreferFloor";
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
    # QT_QPA_PLATFORMTHEME = "qt6ct";
    # QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    # QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    # MOZ_ENABLE_WAYLAND = "1";
    # GDK_SCALE = "1";
  };

  # sway
  security.polkit.enable = true;
  hardware.graphics.enable = true;
  programs.sway.enable = true;
  services.gnome.gnome-keyring.enable = true;

  # Use the systemd-boot EFI boot loader.
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelModules = [ "kvm-amd" ];
  boot.kernelParams = [
    "amd_iommu=on"
    "pcie_aspm=off"
  ];

  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.
  networking.wireless.networks = {
    WRT = {
      psk = "cbcb230481";
    };
  };

  # Set your time zone.
  time.timeZone = "America/Santiago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  services.logind = {
    extraConfig = "HandlePowerKey=suspend";
    lidSwitch = "suspend";
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "dialout"
      "libvirt"
      # "sudo"

    ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      #       firefox
      tree
    ];
  };

  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # lutris x
    lutris
    wine
    wine64
    wineWowPackages.stable
    winetricks
    wineWowPackages.waylandFull

    lshw
    usbutils
    displaylink # nonfree
    xorg.xrandr
    cron
    udisks
    udiskie
    qutebrowser
    pmount
    icu
    helix
    zsh
    stow
    grim
    # mako
    dunst
    # git
    pkgs.libinput
    libnotify # dunst depends on this
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    unzip
    ripgrep
  ];

  fonts = {
    # enableFontDir = true;
    fontDir.enable = true;
    packages = with pkgs; [
      (nerdfonts.override {
        fonts = [
          "JetBrainsMono"
          "NerdFontsSymbolsOnly"
        ];
      })
      line-awesome
      open-sans
      libertine
      ipafont
      kochi-substitute
      freefont_ttf
    ];
    fontconfig.defaultFonts = {
      monospace = [
        "JetBrainsMono Nerd Font Mono"
        "IPAGothic"
        "FreeMono"
      ];
      sansSerif = [
        "Open Sans"
        "IPAGothic"
        "FreeSans"
      ];
      serif = [
        "Linux Libertine O"
        "IPAMincho"
        "FreeSerif"
      ];
    };
  };

  environment.sessionVariables = {
    FONTCONFIG_FILE = "${pkgs.fontconfig.out}/etc/fonts/fonts.conf";
    FONTCONFIG_PATH = "${pkgs.fontconfig.out}/etc/fonts";
    DEFAULT_BROWSER = "${pkgs.qutebrowser}/bin/qutebrowser";
  };

  # bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
        # xdg-desktop-portal-hyprland
      ];
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # nix-prefetch-url --name displaylink-600.zip https://www.synaptics.com/sites/default/files/exe_files/2024-10/DisplayLink%20USB%20Graphics%20Software%20for%20Ubuntu6.1-EXE.zip
  # nix-prefetch-url --name displaylink-600.zip https://www.synaptics.com/sites/default/files/exe_files/2024-05/DisplayLink%20USB%20Graphics%20Software%20for%20Ubuntu6.0-EXE.zip
  # nix-prefetch-url --name displaylink-6.0.0-24.zip https://www.synaptics.com/sites/default/files/exe_files/2024-10/DisplayLink%20USB%20Graphics%20Software%20for%20Ubuntu6.1-EXE.zip
  #https://www.synaptics.com/sites/default/files/exe_files/2024-05/DisplayLink%20USB%20Graphics%20Software%20for%20Ubuntu6.0-EXE.zip
  # hardware.dis

  services.xserver.displayManager.sessionCommands = ''
    ${lib.getBin pkgs.xorg.xrandr}/bin/xrandr --setprovideroutputsource 2 0
  '';

  # mv $PWD/"DisplayLink USB Graphics Software for Ubuntu6.0-EXE.zip" $PWD/displaylink-600.zip
  # nix-prefetch-url file://$PWD/displaylink-600.zip

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?

}
