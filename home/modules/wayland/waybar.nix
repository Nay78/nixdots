{
  pkgs,
  lib,
  self,
  ...
}@inputs:
{
  programs.waybar = {
    enable = true;
    # settings = {
    #   # height = 20;
    #
    # };
  };

}
