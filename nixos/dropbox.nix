{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    dropbox
  ];
  systemd.services.dropbox = {
    Unit = {
      Description = "Dropbox daemon";
      After = [ "network.target" ];
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
    Service = {
      # Type = "simple";
      ExecStart = "${pkgs.dropbox}/bin/dropbox";
      Restart = "on-failure";
      # ExecStop = "${pkgs.dropbox}/bin/dropbox";
      # Restart = "on-failure";
      # RestartSec = "5s";
      # User = "alejg";
      # Group = "alejg";
    };
  };
}
