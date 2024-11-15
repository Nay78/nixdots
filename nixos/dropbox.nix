{ pkgs, unstable, ... }:
let
  inherit (import ../variables.nix) username;
in

{
  environment.systemPackages = with pkgs; [
    unstable.dropbox
  ];

  # systemd.user.services.dropbox = {
  #   description = "Dropbox daemon";
  #   after = [ "network.target" ];
  #   wantedBy = [ "default.target" ];
  #   enable = true;
  #   restartIfChanged = true;
  #   serviceConfig = {
  #     Type = "simple";
  #     ExecStart = "${unstable.dropbox}/bin/dropbox start";
  #     ExecStop = "${unstable.dropbox}/bin/dropbox stop";
  #     PassEnvironment = "DISPLAY";
  #     Restart = "on-failure";
  #     RestartSec = "5s";
  #     User = "${username}"; # Set your actual username here.
  #     Group = "${username}"; # Set your actual group here (probably same as your username).
  #   };
  # };

}
