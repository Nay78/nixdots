{
  description = "A very basic flake";

  inputs = {
    # nixpkgs.url = "github:nixos/nixpkgs/master";
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      python = pkgs.python3;
      fhs = pkgs.buildFHSUserEnv {
        name = "fhs-shell";
        targetPkgs =
          pkgs:
          (with pkgs; [
            python
            gcc
            # gfortran
            pdm
            virtualenv
            zlib
          ]);
      };
    in
    {
      devShells.${system}.default = fhs.env;
    };
}
