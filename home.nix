{ configs, ... }:

let
  username = configs.username;
  homeDirectory = "/home/${configs.username}";
  theme = configs.theme;
  stateVersion = configs.stateVersion;
in {
  imports = [
    ./home-modules/qutebrowser/qutebrowser.nix
    ./home-modules/kitty/kitty.nix
    ./home-modules/bash/bash.nix
    ./home-modules/btop/btop.nix
    ./home-modules/starship.nix
    ./home-modules/git/git.nix
    ./home-modules/helix.nix
    ./home-modules/tmux.nix
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
    ".xmonad/xmonad.hs".source = ./home-modules/xmonad/xmonad.hs;
    ".xmonad/lib/Variables.hs".source = ./home-modules/xmonad/lib/Variables.hs;
    ".xmonad/lib/Borders.hs".source =
      ./home-modules/xmonad/lib/${theme}-Borders.hs;

    ".config/polybar/config.ini".source = ./home-modules/polybar/${theme}.ini;
    "wallpaper.png".source = ./wallpapers/rose-pine/wallpaper.png;
    ".config/git/template".source = ./home-modules/git/template;
  };

  home.stateVersion = stateVersion;
}
