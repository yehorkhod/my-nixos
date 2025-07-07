{ configs, ... }:

let theme = configs.theme;
in {
  programs.alacritty = {
    enable = true;
    settings = {
      window.opacity = 0.95;
      font = {
        normal.family = "3270 Nerd Font";
        size = 18.0;
      };
    };
    theme = theme;
  };
}
