{
  pkgs,
  lib,
  self,
  ...
}@inputs:
{
  programs.waybar = {
    enable = true;
    settings = {
      # height = 20;

    };
  };
  xdg = {
    configFile = {
      "waybar/machiatto.css".text = ''
        /*
        *
        * Catppuccin Macchiato palette
        * Maintainer: rubyowo
        *
        */

        @define-color base   #24273a;
        @define-color mantle #1e2030;
        @define-color crust  #181926;

        @define-color text     #cad3f5;
        @define-color subtext0 #a5adcb;
        @define-color subtext1 #b8c0e0;

        @define-color surface0 #363a4f;
        @define-color surface1 #494d64;
        @define-color surface2 #5b6078;

        @define-color overlay0 #6e738d;
        @define-color overlay1 #8087a2;
        @define-color overlay2 #939ab7;

        @define-color blue      #8aadf4;
        @define-color lavender  #b7bdf8;
        @define-color sapphire  #7dc4e4;
        @define-color sky       #91d7e3;
        @define-color teal      #8bd5ca;
        @define-color green     #a6da95;
        @define-color yellow    #eed49f;
        @define-color peach     #f5a97f;
        @define-color maroon    #ee99a0;
        @define-color red       #ed8796;
        @define-color mauve     #c6a0f6;
        @define-color pink      #f5bde6;
        @define-color flamingo  #f0c6c6;
        @define-color rosewater #f4dbd6;
      '';
    };
  };
}
# programs.waybar = {
#   enable = true;
#   settings = {
#     height = 20;
#
#   }
# };
#
# programs.waybar = {
#   enable = true;
#   settings = {
#     mainBar = {
#       layer = "top"; # Waybar at top layer
#       position = "bottom"; # Waybar position (top|bottom|left|right)
#       height = 30; # Waybar height (to be removed for auto height)
#       # "width": 1280, # Waybar width
#       spacing = 4; # Gaps between modules (4px)
#       # Choose the order of the modules
#       modules-left = [
#         "sway/workspaces"
#         "sway/mode"
#         "sway/scratchpad"
#         "custom/media"
#       ];
#       modules-center = [ "sway/window" ];
#       modules-right = [
#         "mpd"
#         "idle_inhibitor"
#         "pulseaudio"
#         "network"
#         "cpu"
#         "memory"
#         "temperature"
#         "backlight"
#         "keyboard-state"
#         "sway/language"
#         "battery"
#         "battery#bat2"
#         "clock"
#         "tray"
#       ];
#       # Modules configuration
#       keyboard-state = {
#         numlock = true;
#         capslock = true;
#         format = "{name} {icon}";
#         format-icons = {
#           locked = "";
#           unlocked = "";
#         };
#       };
#       "sway/mode" = {
#         format = "<span style=\"italic\">{}</span>";
#       };
#       "sway/scratchpad" = {
#         format = "{icon} {count}";
#         show-empty = false;
#         format-icons = [
#           ""
#           ""
#         ];
#         tooltip = true;
#         tooltip-format = "{app}: {title}";
#       };
#       mpd = {
#         format = "{stateIcon} {consumeIcon}{randomIcon}{repeatIcon}{singleIcon}{artist} - {album} - {title} ({elapsedTime:%M:%S}/{totalTime:%M:%S}) ⸨{songPosition}|{queueLength}⸩ {volume}% ";
#         format-disconnected = "Disconnected ";
#         format-stopped = "{consumeIcon}{randomIcon}{repeatIcon}{singleIcon}Stopped ";
#         unknown-tag = "N/A";
#         interval = 2;
#         consume-icons = {
#           on = " ";
#         };
#         random-icons = {
#           off = "<span color=\"#f53c3c\"></span> ";
#           on == " ";
#         };
#         repeat-icons = {
#           "on" = " ";
#         };
#         single-icons = {
#           on = "1 ";
#         };
#         state-icons = {
#           paused = "";
#           playing = "";
#         };
#         tooltip-format = "MPD (connected)";
#         tooltip-format-disconnected = "MPD (disconnected)";
#       };
#       idle_inhibitor = {
#         format = "{icon}";
#         format-icons = {
#           activated = "";
#           deactivated = "";
#         };
#       };
#       tray = {
#         # "icon-size": 21,
#         spacing = 10;
#       };
#       clock = {
#         # "timezone": "America/New_York",
#         tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
#         format-alt = "{:%Y-%m-%d}";
#       };
#       cpu = {
#         format = "{usage}% ";
#         tooltip = false;
#       };
#       memory = {
#         format = "{}% ";
#       };
#       temperature = {
#         # "thermal-zone": 2,
#         # "hwmon-path": "/sys/class/hwmon/hwmon2/temp1_input",
#         critical-threshold = 80;
#         # "format-critical": "{temperatureC}°C {icon}",
#         format = "{temperatureC}°C {icon}";
#         format-icons = [
#           ""
#           ""
#           ""
#         ];
#       };
#       backlight = {
#         # "device"= "acpi_video1",
#         format = "{percent}% {icon}";
#         format-icons = [
#           ""
#           ""
#           ""
#           ""
#           ""
#           ""
#           ""
#           ""
#           ""
#         ];
#       };
#       battery = {
#         states = {
#           # good= 95,
#           warning = 30;
#           critical = 15;
#         };
#         format = "{capacity}% {icon}";
#         format-charging = "{capacity}% ";
#         format-plugged = "{capacity}% ";
#         format-alt = "{time} {icon}";
#         # format-good= "", # An empty format will hide the module
#         # format-full= "",
#         format-icons = [
#           ""
#           ""
#           ""
#           ""
#           ""
#         ];
#       };
#       "battery#bat2" = {
#         bat = "BAT2";
#       };
#       network = {
#         # interface= "wlp2*", # (Optional) To force the use of this interface
#         format-wifi = "{essid} ({signalStrength}%) ";
#         format-ethernet = "{ipaddr}/{cidr} ";
#         tooltip-format = "{ifname} via {gwaddr} ";
#         format-linked = "{ifname} (No IP) ";
#         format-disconnected = "Disconnected ⚠";
#         format-alt = "{ifname}= {ipaddr}/{cidr}";
#       };
#       pulseaudio = {
#         # scroll-step= 1, # %, can be a float
#         format = "{volume}% {icon} {format_source}";
#         format-bluetooth = "{volume}% {icon} {format_source}";
#         format-bluetooth-muted = " {icon} {format_source}";
#         format-muted = " {format_source}";
#         format-source = "{volume}% ";
#         format-source-muted = "";
#         format-icons = {
#           headphone = "";
#           hands-free = "";
#           headset = "";
#           phone = "";
#           portable = "";
#           car = "";
#           default = [
#             ""
#             ""
#             ""
#           ];
#         };
#         on-click = "pavucontrol";
#       };
#       "custom/media" = {
#         format = "{icon} {}";
#         return-type = "json";
#         max-length = 40;
#         format-icons = {
#           spotify = "";
#           default = "🎜";
#         };
#         escape = true;
#         exec = "$HOME/.config/waybar/mediaplayer.py 2> /dev/null"; # Script in resources folder
#         # exec= "$HOME/.config/waybar/mediaplayer.py --player spotify 2> /dev/null" # Filter player based on name
#       };
#     };
#   };
# };
