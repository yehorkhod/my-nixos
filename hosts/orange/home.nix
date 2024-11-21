{ config, pkgs, inputs, username, ... }:

let
  homeDirectory = "/home/${username}";
in
{
  imports = [
    ../../homeModules/git/git.nix
    ../../homeModules/tmux/tmux.nix
    ../../homeModules/bash/bash.nix
    ../../homeModules/terminals/kitty.nix
    ../../homeModules/starship/starship.nix

    ../../homeModules/editors/helix/helix.nix
    ../../homeModules/editors/neovim/neovim.nix
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
      source = ../../homeModules/awesome;
      recursive = true;
    };
  };

  home.stateVersion = "24.05";
}
