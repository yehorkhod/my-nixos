{ config, pkgs, ... }:

let
  username = "yehorkhod";
  homeDirectory = "/home/${username}";
in
{
  imports = [
    ../../homeModules/neovim/neovim.nix
    ../../homeModules/terminals/kitty.nix
    ../../homeModules/hyprland/hyprland.nix
    ../../homeModules/shells/bash.nix
    ../../homeModules/versionControl/git.nix
    ../../homeModules/waybar/waybar.nix
    ../../homeModules/starship/starship.nix
    ../../homeModules/swaylock/swaylock.nix
    ../../homeModules/tmux/tmux.nix
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
    policies = {
      DisableAppUpdate = true;
    };
  };

  home.stateVersion = "24.05";
}
