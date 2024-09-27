{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    neovim
    stylua
  ];

}
