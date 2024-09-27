{ config, pkgs, ... }:
{
  # wayland.windowManager.hyprland = {
  #   # Whether to enable Hyprland wayland compositor
  #   enable = true;
  #   # The hyprland package to use
  #   package = pkgs.hyprland;
  #   # Whether to enable XWayland
  #   xwayland.enable = true;
  #
  #   # Optional
  #   # Whether to enable hyprland-session.target on hyprland startup
  #   # systemd.enable = true;
  # };

  # programs.hyprland.enable = true;
  # environment.sessionVariables.NIXOS_OZONE_WL = "1";
  # environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";

  # environment.variables.NIXOS_OZONE_WL = "1";
  home.packages = with pkgs; [

    hyprland
    blueberry
    pyprland
    hyprpicker
    hyprcursor
    hyprlock
    hypridle
    # hyprpaper

  ];
  # wayland.windowManager.hyprland.settings = {
  #   decoration = {
  #     shadow_offset = "0 5";
  #     "col.shadow" = "rgba(00000099)";
  #   };
  #
  #   "$mod" = "SUPER";
  #
  #   bindm = [
  #     # mouse movements
  #     # "$mod, mouse:272, movewindow"
  #     # "$mod, mouse:273, resizewindow"
  #     # "$mod ALT, mouse:272, resizewindow"
  #
  #   ];
  # };
}
