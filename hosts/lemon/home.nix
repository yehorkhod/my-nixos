{ configs, ... }:

let
  username = configs.username;
  homeDirectory = "/home/${configs.username}";
in {
  imports = [
    ../../home-modules/git/git.nix
    ../../home-modules/tmux/tmux.nix
    ../../home-modules/bash/bash.nix
    ../../home-modules/waybar/waybar.nix
    ../../home-modules/terminals/kitty.nix
    ../../home-modules/starship/starship.nix
    ../../home-modules/swaylock/swaylock.nix

    ../../home-modules/neovim/neovim.nix

    ../../home-modules/window-managers/hyprland/hyprland.nix
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

  home.stateVersion = "24.05";
}
