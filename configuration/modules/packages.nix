{
  pkgs,
  inputs,
  username,
  ...
}:

{
  environment = {
    sessionVariables.STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/${username}/.steam/root/compatibilitytools.d";
    etc."dualfn.yaml".text = ''
      MAPPINGS:
        - KEY: KEY_CAPSLOCK
          TAP: KEY_ESC
          HOLD: KEY_LEFTMETA
    '';
    systemPackages = with pkgs; [
      # Utilities
      bc
      jq
      fzf
      git
      zip
      feh
      tmux
      btop
      wget
      pass
      slop
      xclip
      unzip
      conda
      dmenu
      shotgun
      img2pdf
      pamixer
      starship
      man-pages
      diff-so-fancy
      brightnessctl
      docker-compose
      man-pages-posix

      # Applications
      vlc
      vial
      kitty
      pinta
      helix
      slides
      zathura
      discord
      zoom-us
      obs-studio
      qutebrowser
      telegram-desktop
      inputs.neovim-nightly-overlay.packages.${pkgs.system}.default

      # Gaming
      polymc
      mangohud
      protonup
    ];
  };

  programs = {
    nano.enable = false;
    gnupg.agent.enable = true;

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

  fonts.packages = with pkgs; [
    corefonts
    vistafonts
    nerd-fonts.fira-code
  ];
}
