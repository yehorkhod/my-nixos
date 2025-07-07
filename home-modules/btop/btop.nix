{ configs, ... }:

let
  theme = configs.theme;
  themes = import ./themes.nix;
in {
  programs.btop = {
    enable = true;
    extraConfig = ''
      color_theme="${theme}"
    '';
    themes = themes;
  };
}
