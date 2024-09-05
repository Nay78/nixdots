
{ config, lib, pkgs, ... }:

{
  # PORTALS
  xdg = {
    autostart.enable = true;
    portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal
        pkgs.xdg-desktop-portal-gtk
      ];
    };
  };

  services = {
    xserver = {
      enable = true;
      xkb.layout = "latam";
      excludePackages = [ pkgs.xterm ];
      displayManager.gdm = {
        enable = true;
        wayland = true;
      };
    };

    libinput.enable = true;
    dbus.enable = true;
    gvfs.enable = true;
    tumbler.enable = true;
    gnome = {
      sushi.enable = true;
      gnome-keyring.enable = true;    
    };
  };

  # WAYLAND
  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
      #xwayland.hidpi = true;
    };
    waybar = {
      enable = true;
      # package = pkgs.waybar.overrideAttrs ()
    };
  };

  environment.systemPackages = with pkgs; [
    kitty
    polkit_gnome
    libva-utils
    fuseiso
    #hyprland-share-picker
    #wl-v
    rofi-wayland
  ];

  environment.sessionVariables = {
    # WLR_NO_HARDWARE_CURSORS = "1"; # if cursor becomes invisible
    
    NIXOS_OZONE_WL = "1";
  };

  #hardware.opengl = {
  #  enable = true;
  #  driSupport = true;

    # most wayland compositors need this
    # nvidia.modesetting.enable = true;
  #};

  #services.xserver.videoDrivers = [ "amdgpu" ];
}
