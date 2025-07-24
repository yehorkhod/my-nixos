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

  home.file = { "wallpaper.png".source = ./wallpapers/rose-pine/wallpaper.png; };

  home.stateVersion = stateVersion;
}
