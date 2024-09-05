{ pkgs, ... }@args:
{
  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;
  home-manager.users.alejg = import ./home.nix args; # inputs.neovim.packages.x86_64-linux.neovim;
}
