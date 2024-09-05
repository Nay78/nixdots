# /etc/nixos/flake.nix
{
  description = "lenovopc flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager"; 
    home-manager.inputs.nixpkgs.follows = "nixpkgs"; 
  };

  outputs = { self, nixpkgs, home-manager, ... }: 
  
    let 
       system = "x86_64-linux"; #current system
       # pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
       # lib = nixpkgs.lib;

    
       mkSystem = hostname: 
        nixpkgs.lib.nixosSystem {
        modules = [
          ./configuration.nix
	  { networking.hostName = hostname; }
	  home-manager.nixosModules.home-manager
	  ./home
		#  {
		#           home-manager.useGlobalPkgs = true;
		#           home-manager.useUserPackages = true;
		#           home-manager.users.alejg = { pkgs, ... }: {
		#             home.username = "alejg";
		#      home.homeDirectory = "/home/alejg";
		#      programs.home-manager.enable = true;
		#      home.packages = with pkgs; [
		#               keepassxc
		# firefox
		#      ];
		#      home.stateVersion = "24.05";
		#
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

    in {
      nixosConfigurations = {
      laptop = mkSystem "laptop";
    };

    };
   
      
  }
# }
