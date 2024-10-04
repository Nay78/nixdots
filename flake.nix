{
  description = "1st flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # nixpkgs
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    stable.url = "github:NixOS/nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    gBar.url = "github:scorpion-26/gBar";
    nix-ld.url = "github:Mic92/nix-ld";
    nix-ld.inputs.nixpkgs.follows = "nixpkgs";

    qbpm.url = "github:pvsr/qbpm";
    qbpm.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      unstable,
      gBar,
      nix-ld,
      qbpm,
      ...
    }@inputs:
    # outputs = { self, nixpkgs, home-manager, unstable, ... }@inputs: 

    let
      inherit (import ./variables.nix) hostname system username;
      # system = "x86_64-linux"; # current system
      # username = "alejg";
      # pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
      # lib = nixpkgs.lib;

      mkSystem =
        hostname:
        nixpkgs.lib.nixosSystem {

          specialArgs = {
            # inherit (inputs);
            unstable = import inputs.unstable {
              inherit system;
              config.allowUnfree = true;
            };
            stable = import inputs.stable {
              inherit system;
              config.allowUnfree = true;
            };
            self = self;

          };
          modules = [
            home-manager.nixosModules.home-manager
            { networking.hostName = hostname; }
            ./configuration.nix
            ./home
            ./nixos/programming.nix
            nix-ld.nixosModules.nix-ld
            # qbpm.packages.${system}
            # {
            #   environment.systemPackages = with pkgs; [
            #     qbpm
            #   ];
            # }

            # ./nixos/hyprland.nix
            #             home.username = "alejg";
            #      home.homeDirectory = "/home/alejg";
            #      programs.home-manager.enable = true;
            #      home.packages = with pkgs; [
            #               keepassxc
            # firefox
            #      ];
            #      home.stateVersion = "24.05";
            #             wayland.windowManager.sway = {
            #        enable = true;
            #        config = rec {
            # terminal = "alacritty";
            #        modifier = "Mod4";
            # startup = [
            #   {command = "firefox";}
            # ];
            #      };
            #      };
            #        };
            #  }
            #end
          ];
        };

    in
    {
      nixosConfigurations = {
        laptop = mkSystem "laptop";
      };

    };

}
# }
