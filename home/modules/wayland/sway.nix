{ pkgs, lib, ... }:
{
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    config = rec {
      bars = [ { command = "waybar"; } ];
      terminal = "alacritty";
      modifier = "Mod4";
      menu = "${pkgs.fuzzel}/bin/fuzzel";
      # menu = "${pkgs.rofi}/bin/rofi -show combi";
      keybindings = lib.mkOptionDefault {
        # Brightness
        XF86MonBrightnessDown = ''exec "brightnessctl set 5%-"'';
        XF86MonBrightnessUp = ''exec "brightnessctl set +5%"'';

        # Volume
        XF86AudioRaiseVolume = ''exec "wpctl set-volume @DEFAULT_SINK@ 0.01+"'';
        XF86AudioLowerVolume = ''exec "wpctl set-volume @DEFAULT_SINK@ 0.01-"'';
        XF86AudioMute = ''exec "wpctl set-mute @DEFAULT_SINK@ toggle"'';
        XF86AudioNext = ''exec "playerctl next"'';
        XF86AudioPrev = ''exec "playerctl previous"'';
        XF86AudioPlay = ''exec "playerctl play-pause"'';

        # Screenshot
        Print = ''exec grim -g "$(slurp)" /tmp/$(date +'%H:%M:%S.png')'';
        "Ctrl+Print" = "exec ocr-screenshot";
        # Password manager

        "${modifier}+p" = "exec keepassxc";
        "${modifier}+b" = "exec qutebrowser";

        # power
        XF86PowerOff = "exec systemctl suspend";

        # extraOptions
        "${modifier}+Alt+Left" = "exec swaymsg resize shrink width 10px";
        "${modifier}+Alt+Right" = "exec swaymsg resize grow width 10px";
        "${modifier}+Alt+Up" = "exec swaymsg resize shrink height 10px";
        "${modifier}+Alt+Down" = "exec swaymsg resize grow height 10px";

      };
      # Resize windows
      input = {
        # Keyboard
        "*" = {
          xkb_layout = "us";
          # xkb_options = "grp:alt_shift_toggle";
          repeat_delay = "200";
          repeat_rate = "65";
        };
        "1:1:AT_Translated_Set_2_keyboard" = {
          repeat_delay = "100";
          repeat_rate = "65";
          xkb_numlock = "enable";

        };
        "type:touchpad" = {
          tap = "enabled";
          natural_scroll = "enabled";
          scroll_factor = "0.5";
          dwt = "disabled";
        };
        # TODO
        # "1386:890:Wacom_One_by_Wacom_S_Pen" = { };
      };
    };
    extraConfig = ''
      default_border none
      # workspace_layout tabbed
      # hide_edge_borders smart

       # start the server
      exec_always sway-scratch serve

      # bind scratchpads to keys
      bindsym Mod4+apostrophe exec sway-scratch call alacritty -position left
      bindsym Mod4+bar exec sway-scratch call alacritty -position right
      bindsym Mod4+question exec sway-scratch call alacritty -position right
      # bindsym Mod4+? exec sway-scratch call alacritty -position right
      # bindsym Mod4+^ exec sway-scratch call alacritty -position right
      # bindsym Mod4+Shift+apostrophe exec sway-scratch call kitty -position right  # '
      # bindsym Mod4+Shift+backslash exec sway-scratch call kitty -position right  # |
      # bindsym Mod4+Shift+slash exec sway-scratch call kitty -position right  # ?

      # bindsym Mod4+Shift+2 exec sway-scratch call kitty -position left  # @ symbol
      # bindsym Mod4+Shift+' exec sway-scratch call kitty -position right  # '
      # bindsym Mod4+Shift+\| exec sway-scratch call kitty -position right  # |
      # bindsym Mod4+Shift+/ exec sway-scratch call kitty -position right  # ?
      # bindsym Mod4+Shift+6 exec sway-scratch call kitty -position right  # ^ (caret)
    '';
    # extraOptions = [ "--unsupported-gpu" ];
    # TODO: migrate to config
    # extraConfig = ''
    #   # HDMI workspace 9
    #   workspace 9 output HDMI-A-1
    # '';
  };
}
