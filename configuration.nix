# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (import ./variables.nix) hostname system username;
in
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    # ./nixos/sddm.nix
    # ./hyprland.nix
    #    ./greetd.nix
    #     home-manager.nixosModules.home-manager
  ];

  services.udev.extraRules = ''
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{serial}=="*vial:f64c2b3c*", MODE="0660", GROUP="100", TAG+="uaccess", TAG+="udev-acl"
    KERNEL=="hidraw*", MODE="0766"
  '';

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
  # nixpkgs = {
  #   config = {
  #     allowUnfree = true;
  #     packageOverrides = pkgs: {
  #       unstable = import (fetchTarball "channel:nixos-unstable") { config = config.nixpkgs.config; };
  #     };
  #   };
  # };
  # allowUnfree = true;
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
  # programs.hyprland.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";

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

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

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
      # "sudo"

    ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      #       firefox
      tree
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    helix
    zsh
    alacritty
    stow
    grim
    mako
    # git
    pkgs.libinput
    libnotify # dunst depends on this
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    # gnumake
    # gcc
    # nodejs
    # go
    # cargo
    unzip
    ripgrep
    # nixfmt-rfc-style
    # xdg-desktop-portal-gnome
    # xdg-desktop-portal-gtk
    # xdg-desktop-portal-hyprland
    # xdg-desktop-portal-kde
    # xdg-desktop-portal-wlr
  ];
  # fonts

  fonts.fontDir.enable = true;
  fonts.packages =
    # [ linja-sike ]
    # ++ (with pkgs; [
    (
      with pkgs;
      [
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
      ]
    );
  fonts.fontconfig.defaultFonts = {
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
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

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
