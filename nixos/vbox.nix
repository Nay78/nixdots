{ pkgs, ... }:
let
  inherit (import ../variables.nix) username;
in
{
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ username ];
  virtualisation.virtualbox.guest.enable = true;
  virtualisation.virtualbox.guest.dragAndDrop = true;
}
