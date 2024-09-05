# /etc/nixos/flake.nix
{
  description = "lenovopc flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager"; 
    home-manager.inputs.nixpkgs.follows = "nixpkgs"; 
  };

  outputs = { self, nixpkgs, home-manager }: {
    nixosConfigurations = {
    
      alejg = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
	  #./greetd.nix
	  home-manager.nixosModules.home-manager
	  {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.alejg = { pkgs, ... }: {
              home.username = "alejg";
	      home.homeDirectory = "/home/alejg";
	      programs.home-manager.enable = true;
	      home.packages = with pkgs; [
                keepassxc
		firefox
	      ];
	      home.stateVersion = "24.05";

              wayland.windowManager.sway = {
	        enable = true;
	        config = rec {
		terminal = "alacritty";
	        modifier = "Mod4";
		startup = [
		  {command = "firefox";}
		];
	        #output = {
	        #  "Virtual-1" = {
	            #mode = "1920x1080@60Hz"
	        #  };
	        #};
	     };
	      };
         };
	  }
	 ];
      };
      
    };
  };
}

