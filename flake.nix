{
  description = "1st flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # nixpkgs
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    stable.url = "github:NixOS/nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # impurity.url = "github:outfoxxed/impurity.nix";
    # pyfhsflake.url = "path:./nixos/python";
    # pyfhsflake.inputs.nixpkgs.follows = "nixpkgs";
    # gBar.url = "github:scorpion-26/gBar";
    # nix-ld.url = "github:Mic92/nix-ld";
    # nix-ld.inputs.nixpkgs.follows = "nixpkgs";

    # qbpm.url = "github:pvsr/qbpm";
    # qbpm.inputs.nixpkgs.follows = "nixpkgs";

    # qutebrowser-flake.url = import ./nixos/qutebrowser-profiles.nix;
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      unstable,
      # pyfhsflake,
      # gBar,
      # nix-ld,
      # qbpm,
      nix-index-database,
      ...
    }@inputs:
    # outputs = { self, nixpkgs, home-manager, unstable, ... }@inputs: 

    let
      inherit (import ./variables.nix) hostname system username;
      # pkgs = nixpkgs.legacyPackages.${system};
      fhs = unstable.buildFHSUserEnv {
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

      # inherit (import ./nixos/python/flake.nix) ;
      # system = "x86_64-linux"; # current system
      #
      # username = "alejg";
      # pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
      # lib = nixpkgs.lib;
      # nixpkgs.con

      mkSystem =
        hostname:
        nixpkgs.lib.nixosSystem {

          specialArgs = {
            # inherit (inputs);
            unstable = import inputs.unstable {
              inherit system;
              # config.allowUnfree = true;
              config = {
                allowUnfree = true;
                android_sdk.accept_license = true;
              };
            };
            stable = import inputs.stable {
              inherit system;
              config.allowUnfree = true;
            };
            self = self;

          };
          # inherit pkgs;
          modules = [
            home-manager.nixosModules.home-manager
            # nix-index-database.hmModules.nix-index
            nix-index-database.nixosModules.nix-index
            { networking.hostName = hostname; }
            ./configuration.nix
            ./home
            ./nixos/programming.nix
            # nix-index-database.nixosModules.nix-index-database
            # nix-ld.nixosModules.nix-ld
            # qbpm.packages.${system}
            # pyfhsflake.devShells.x86_64-linux.default
          ];
        };

    in
    {

      devShells.${system}.default = fhs.env;
      nixosConfigurations = {
        laptop = mkSystem "laptop";
      };

    };

}
# }
