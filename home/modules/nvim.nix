{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    nvim
    stylua
  ];

}
