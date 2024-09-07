{
  pkgs,
  lib,
  unstable,
  self,
  ...
}@inputs:
{

  programs.wezterm = {
    enable = true;
    extraConfig = ''
        local wezterm = require 'wezterm'
        return {
          enable_tab_bar = true,
          front_end = "WebGpu", 
          color_scheme = "Catppuccin Mocha",
          -- color_scheme = "MaterialDesignColors",

          font = wezterm.font_with_fallback {
             'JetBrains Mono',
             'FreeMono',
          },
        window_padding = {
             left = 0,
             right = 0,
             bottom = 0,
             top = 0,
        },
        hide_tab_bar_if_only_one_tab = false,
        use_fancy_tab_bar = false,
        tab_bar_at_bottom = true,
         -- color_scheme = "Dark Pastel",
         -- font_size = 14.1,
      }
    '';
  };
}
