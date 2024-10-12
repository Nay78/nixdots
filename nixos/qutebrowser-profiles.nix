# {
#   description = "A flake to fetch and install an executable from GitHub";
#
#   outputs =
#     { self, nixpkgs }:
#     {
#       packages.x86_64-linux = nixpkgs.lib.mkShell {
#         buildInputs = [
#           nixpkgs.stdenv
#           nixpkgs.git
#           nixpkgs.makeWrapper # If the repo needs wrapping for executables
#           # Add other build dependencies like `gcc`, `cmake`, etc.
#         ];
#
#         src = nixpkgs.fetchFromGitHub {
#           owner = "jtyers"; # GitHub user/org
#           repo = "qutebrowser-profile"; # Repository name
#           # rev = "commit_hash"; # Git commit hash
#           # sha256 = "sha256-Px7VtJidPF4UurWLmA5X/ZwI9a09VaOyno/9gJOUW24="; # Hash for the source
#         };
#
#         buildPhase = ''
#           cd $src
#           make                # Adjust this to the correct build command
#         '';
#
#         installPhase = ''
#           mkdir -p $out/bin
#           cp qutebrowser-profile $out/bin/qutebrowser-profile  # Replace with actual executable path
#         '';
#       };
#     };
# }
# configuration.nix or a separate .nix file
{ pkgs, ... }:

let
  qutebrowser-profile = pkgs.stdenv.mkDerivation {
    name = "qutebrowser-profile";
    # version = "1.0.0"; # Specify the version here

    src = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/jtyers/qutebrowser-profile/refs/heads/master/qutebrowser-profile";
      sha256 = "sha256-Izc/ZxtKxOpiMN2RTdUW6z1/YihVKmugb/Q+OjGetbI="; # Add the correct hash
    };

    phases = [ "installPhase" ];

    installPhase = ''
      install -Dm755 $src $out/bin/qutebrowser-profile
    '';
  };
in
{
  environment.systemPackages = with pkgs; [
    qutebrowser-profile
  ];
}
