{ configs, ... }:

let
  theme = configs.theme;
  themes = import ./themes.nix;
in {
  programs.kitty = {
    enable = true;
    font = {
      name = "3270 Nerd Font";
      size = 18;
    };
    keybindings = {
      "ctrl+plus" = "change_font_size all +2.0";
      "ctrl+minus" = "change_font_size all -2.0";
    };
    extraConfig = ''
      enable_audio_bell no

      background_opacity 0.95
      ${
        if theme == "everforest" then themes.everforest
        else if theme == "gruvbox-light" then themes."gruvbox-light"
        else themes."rose-pine"
      }
    '';
  };
}
