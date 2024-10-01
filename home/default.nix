{ pkgs, ... }@args:
let
  inherit (import ../variables.nix) hostname system username;
in

{
  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;
  home-manager.users.${username} = import ./home.nix args; # inputs.neovim.packages.x86_64-linux.neovim;
}
