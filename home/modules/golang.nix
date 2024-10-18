{
  config,
  lib,
  pkgs,
  # buildGoModule,
  # fetchFromGitHub,
  ...
}:
{

  programs.go = {
    enable = true;
    # package = pkgs.go_1_20;
  };

  # home.packages = with pkgs; [
  # home.packages = with pkgs; [
  #   (pkgs.buildGoModule {
  #     pname = "gomobile";
  #     version = "latest";
  #     src = pkgs.fetchFromGitHub {
  #       owner = "golang";
  #       repo = "mobile";
  #       rev = "latest"; # Replace with a specific version or commit
  #       # sha256 = "<sha256-hash>";
  #     };
  #     vendorHash = null;
  #     subPackages = [ "cmd/gomobile" ];
  #     # goPackagePath = "golang.org/x/mobile";
  #   })
  # ];

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

# {
#   # inputs.nixpkgs.url = "github:NixOS/nixpkgs";
#
#   outputs = { self, nixpkgs, ... }:
#     let
#       pkgs = import nixpkgs { system = "x86_64-linux"; };
#     in {
#       defaultPackage.x86_64-linux = pkgs.buildGoModule {
#         pname = "gomobile";
#         version = "latest";
#         src = pkgs.fetchFromGitHub {
#           owner = "golang";
#           repo = "mobile";
#           rev = "latest"; # Replace with a specific version or commit
#           sha256 = "<sha256-hash>";
#         };
#         vendorSha256 = null;
#         subPackages = [ "cmd/gomobile" ];
#         goPackagePath = "golang.org/x/mobile";
#       };
#     };
# }
