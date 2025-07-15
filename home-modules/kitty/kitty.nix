{ configs, ... }:

let
  theme = configs.theme;
  themes = import ./themes.nix;
in {
  programs.kitty = {
    enable = true;
    font = {
      name = "FiraCode Nerd Font Mono";
      size = 18;
    };
    keybindings = {
      "ctrl+plus" = "change_font_size all +2.0";
      "ctrl+minus" = "change_font_size all -2.0";
    };
    extraConfig = ''
      enable_audio_bell no

      background_opacity 0.95
      ${themes.${theme}}
    '';
  };
}
