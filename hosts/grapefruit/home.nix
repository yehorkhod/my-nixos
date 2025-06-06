{ configs, ... }:

let
  username = configs.username;
  homeDirectory = "/home/${configs.username}";
  theme = configs.theme;
in {
  imports = [
    ../../home-modules/git/git.nix
    ../../home-modules/tmux/tmux.nix
    ../../home-modules/bash/bash.nix
    ../../home-modules/terminals/kitty.nix
    ../../home-modules/starship/starship.nix

    ../../home-modules/neovim/neovim.nix
  ];

  home.username = username;
  home.homeDirectory = homeDirectory;

  programs.home-manager.enable = true;
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  programs.firefox = {
    enable = true;
    policies = { DisableAppUpdate = true; };
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "x-scheme-handler/tg" = "org.telegram.desktop.desktop";

      # Browser things
      "text/html" = "org.qutebrowser.qutebrowser.desktop";
      "x-scheme-handler/http" = "org.qutebrowser.qutebrowser.desktop";
      "x-scheme-handler/https" = "org.qutebrowser.qutebrowser.desktop";
      "x-scheme-handler/about" = "org.qutebrowser.qutebrowser.desktop";
      "x-scheme-handler/unknown" = "org.qutebrowser.qutebrowser.desktop";

      # PDF files
      "application/pdf" = "org.pwmt.zathura.desktop";
    };
  };

  home.file = {
    ".xmonad/xmonad.hs".source = ../../home-modules/window-managers/xmonad/xmonad.hs;
    ".xmonad/lib/Variables.hs".source = ../../home-modules/window-managers/xmonad/lib/Variables.hs;
    ".xmonad/lib/Borders.hs".source = ../../home-modules/window-managers/xmonad/lib/${theme}-Borders.hs;

    ".config/polybar/config.ini".source = ../../home-modules/polybar/${theme}/config.ini;

    ".config/qutebrowser/color_setup.py".source = ../../home-modules/qutebrowser/color_setup.py;
    ".config/qutebrowser/config.py".source = ../../home-modules/qutebrowser/config.py;
    ".config/qutebrowser/theme.py".source = ../../home-modules/qutebrowser/themes/${theme}.py;

    "wallpaper.png".source = ../../wallpapers/${theme}/wallpaper.png;

    ".config/git/template".source = ../../home-modules/git/template;
  };

  home.stateVersion = "24.05";
}
