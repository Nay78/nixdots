{ config, pkgs, ... }:
{
imports = [
    # ./sddm.nix
    ./gtk.nix
  ];
  # wayland.windowManager.hyprland = {
  #   # Whether to enable Hyprland wayland compositor
  #   enable = true;
  #   # The hyprland package to use
  #   package = pkgs.hyprland;
  #   # Whether to enable XWayland
  #   xwayland.enable = true;
  #
  #   # Optional
  #   # Whether to enable hyprland-session.target on hyprland startup
  #   # systemd.enable = true;
  # };

  # programs.hyprland.enable = true;
  # environment.sessionVariables.NIXOS_OZONE_WL = "1";
  # environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";

  # environment.variables.NIXOS_OZONE_WL = "1";
  home.packages = with pkgs; [

    # hyprland
    blueberry
    pyprland
    # hyprpicker
    hyprcursor
    hyprlock
    hypridle
    # hyprpaper

        # wlogout
    # rofi-wayland
    killall

# --------------------------------------------------- // system
    xwayland
    wayland-scanner
    hyprwayland-scanner
pipewire                                               # audio/video server
# pipewire-alsa                                          # pipewire alsa client
# pipewire-audio                                         # pipewire audio client
# pipewire-jack                                          # pipewire jack client
# pipewire-pulse                                         # pipewire pulseaudio client
# gst-plugin-pipewire                                    # pipewire gstreamer client
wireplumber                                            # pipewire session manager
pavucontrol                                            # pulseaudio volume control
pamixer                                                # pulseaudio cli mixer
networkmanager                                         # network manager
networkmanagerapplet                                 # network manager system tray utility
bluez                                                  # bluetooth protocol stack
bluez-tools                                            # bluetooth utility cli
blueman                                                # bluetooth manager gui
brightnessctl                                          # screen brightness control
playerctl
udiskie                                                # manage removable media

# --------------------------------------------------- // Display Manager
# sddm                                                   # display manager for KDE plasma
# qt5-quickcontrols                                      # for sddm theme ui elements
# qt5-quickcontrols2                                     # for sddm theme ui elements
# qt5-graphicaleffects                                   # for sddm theme effects

# --------------------------------------------------- // Window Manager
hyprland                                               # wlroots-based wayland compositor
dunst                                                  # notification daemon
rofi-wayland                                           # application launcher
waybar                                                 # system bar
swww                                                   # wallpaper
# swaylock-effects                                       # lock screen
wlogout                                                # logout menu
grimblast                                              # screenshot tool
hyprpicker                                             # color picker
slurp                                                  # region select for screenshot/screenshare
swappy                                                 # screenshot editor
cliphist                                               # clipboard manager

# --------------------------------------------------- // Dependencies
polkit_gnome                                           # authentication agent
# xdg-desktop-portal-hyprland                            # xdg desktop portal for hyprland
# pacman-contrib                                         # for system update check
# python-pyamdgpuinfo                                    # for amd gpu info
parallel                                               # for parallel processing
jq                                                     # for json processing
imagemagick                                            # for image processing
# qt5-imageformats                                       # for dolphin image thumbnails
# ffmpegthumbs                                           # for dolphin video thumbnails
# kde-cli-tools                                          # for dolphin file type defaults
libnotify                                              # for notifications

# --------------------------------------------------- // Theming
libsForQt5.qt5ct
kdePackages.qt6ct
nwg-look                                               # gtk configuration tool
# qt5ct                                                  # qt5 configuration tool
# qt6ct                                                  # qt6 configuration tool
# kvantum                                                # svg based qt6 theme engine
libsForQt5.qtstyleplugin-kvantum
kdePackages.qtstyleplugin-kvantum
libsForQt5.kwayland-integration
# kvantum-qt5                                            # svg based qt5 theme engine
# qt5-wayland                                            # wayland support in qt5
# qt6-wayland                                            # wayland support in qt6
    #
    #### QT
    qtcreator
    qt5.qtwayland qt6.qtwayland qt6.qmake
    libsForQt5.qt5.qtwayland qt5ct
    gsettings-qt

    # gtk2
    gtk3 gtk4 
    # tela-circle-icon-theme


# --------------------------------------------------- // Applications
# firefox                                                # browser
# kitty                                                  # terminal
# dolphin                                                # kde file manager
# ark                                                    # kde file archiver
# vim                                                    # terminal text editor
# code                                                   # ide text editor

# --------------------------------------------------- // Shell
# eza|zsh                                                # file lister for zsh
# oh-my-zsh-git|zsh                                      # plugin manager for zsh
# zsh-theme-powerlevel10k-git|zsh oh-my-zsh-git          # theme for zsh
# eza|fish                                               # file lister for fish
# starship|fish                                          # customizable shell prompt
# fastfetch                                              # system information fetch tool
# pokemon-colorscripts-git|zsh                           # display pokemon sprites



  ];
  # wayland.windowManager.hyprland.settings = {
  #   decoration = {
  #     shadow_offset = "0 5";
  #     "col.shadow" = "rgba(00000099)";
  #   };
  #
  #   "$mod" = "SUPER";
  #
  #   bindm = [
  #     # mouse movements
  #     # "$mod, mouse:272, movewindow"
  #     # "$mod, mouse:273, resizewindow"
  #     # "$mod ALT, mouse:272, resizewindow"
  #
  #   ];
  # };
}
