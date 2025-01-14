{ config, pkgs, configs, ... }:

let
  theme = configs.theme;
  themes = import ./themes.nix;
in {
  programs.kitty = {
    enable = true;
    font = {
      name = "3270 Nerd Font";
      size = 14;
    };
    extraConfig = ''
      enable_audio_bell no

      background_opacity 0.95
      ${if theme == "rose-pine" then themes.rose-pine else themes.everforest}
    '';
  };
}
