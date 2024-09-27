{
  config,
  lib,
  pkgs ? import <nixpkgs> { },
  # buildGoModule,
  # fetchFromGitHub,
  ...
}:
{

  programs.go = {
    enable = true;
    # package = pkgs.go_1_20;
  };
  # sway-scripts = pkgs.buildGoModule rec {
  #   name = "sway-scripts";
  #   src = pkgs.fetchFromGitHub {
  #     owner = "kndndrj";
  #     repo = "sway-scripts";
  #     rev = "master";
  #     # sha256 = "108s1vjxbivpd1mvrj615khalbv8f2haszh4zyvi451kdrcakpv6";
  #   };
  #   vendorHash = null;
  # };

}
