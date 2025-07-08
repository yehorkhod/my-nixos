{ configs, ... }:

let
  config = builtins.readFile ./config.py;
  theme = configs.theme;
  palette = builtins.readFile ./themes/${theme}.py;
in {
  programs.qutebrowser = {
    enable = true;
    extraConfig = ''
      ${palette}
      ${config}
    '';
  };
}
