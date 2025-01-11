{ config, lib, pkgs, configs, ... }:

let
  username = configs.username;
in
{
  programs = {
    neovim.enable = true;
    gnupg.agent.enable = true;
    tmux.enable = true;

    # Games
    gamemode.enable = true;
    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
  };

  nixpkgs.config.allowUnfree = true;
}
