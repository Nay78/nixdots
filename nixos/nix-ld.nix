{...}:
programs = {
    nix-ld = {
      enable = true;

      libraries = with pkgs; [
        glib
        nss
        dbus
        atk
        nspr
      ];

    };
  }
