{ config, pkgs, inputs, username, ... }:

let
  homeDirectory = "/home/${username}";
in
{
  imports = [
    ../../home-modules/git/git.nix
    ../../home-modules/tmux/tmux.nix
    ../../home-modules/bash/bash.nix
    ../../home-modules/terminals/kitty.nix
    ../../home-modules/starship/starship.nix

    ../../home-modules/editors/helix/helix.nix
    ../../home-modules/editors/neovim/neovim.nix
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

  home.file = {
    ".config/awesome" = {
      source = ../../home-modules/awesome;
      recursive = true;
    };
    ".config/qutebrowser" = {
      source = ../../home-modules/qutebrowser;
      recursive = true;
    };
  };

  home.stateVersion = "24.05";
}
