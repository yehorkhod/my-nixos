{ configs, ... }:

let
  username = configs.username;
  homeDirectory = "/home/${configs.username}";
  theme = configs.theme;
  stateVersion = configs.stateVersion;
in {
  home.username = username;
  home.homeDirectory = homeDirectory;
  programs.home-manager.enable = true;
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  home.file = {
    ".xmonad/xmonad.hs".source = ./home-modules/xmonad/xmonad.hs;
    ".xmonad/lib/Variables.hs".source = ./home-modules/xmonad/lib/Variables.hs;
    ".xmonad/lib/Borders.hs".source =
      ./home-modules/xmonad/lib/${theme}-Borders.hs;
    "wallpaper.png".source = ./wallpapers/rose-pine/wallpaper.png;
  };

  home.stateVersion = stateVersion;
}
