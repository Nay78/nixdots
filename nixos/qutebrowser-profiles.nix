# configuration.nix or a separate .nix file
{ pkgs, ... }:

let
  mybinary = pkgs.stdenv.mkDerivation {
    pname = "qutebrowser-profile";
    version = "1.0.0"; # Specify the version here

    src = pkgs.fetchurl {
      url = "https://github.com/jtyers/qutebrowser-profile";
      # sha256 = "sha256-hash-of-the-binary"; # Add the correct hash
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
