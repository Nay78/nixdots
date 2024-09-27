{
  pkgs,
  unstable,
  stable,
  ...
}@args:

{
  # Enable Hyprland
  # programs.hyprland.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";

  # pkgs.hyprland = {
  #   type = "git";
  #   url = "https://github.com/hyprwm/Hyprland";
  #   submodules = true;
  # };

  # environment.systemPackages = with pkgs; [
  #   dconf
  #   xwayland
  #   xdg-desktop-portal-gtk
  #   xdg-desktop-portal-hyprland
  #   xdg-desktop-portal-wlr
  #   xdg-desktop-portal-kde
  #
  #   unstable.wayland-scanner
  #   hyprwayland-scanner
  #   unstable.waylandwy
  #
  #   pyprland
  #   stable.hyprland
  #   hyprpicker
  #   hyprcursor
  #   hyprlock
  #   hypridle
  #   hyprpaper
  #
  #   wezterm
  #   cool-retro-term
  #
  #   starship
  #   helix
  #
  #   qutebrowser
  #   zathura
  #   mpv
  #   imv
  # ];
}
