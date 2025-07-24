{ inputs, ... }:

{
  programs = {
    nano.enable = false;
    gnupg.agent.enable = true;
    tmux.enable = true;

    # Games
    gamemode.enable = true;
    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
  };

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [ inputs.polymc.overlay ];
  };
}
