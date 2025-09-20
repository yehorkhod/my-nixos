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
      # LSPs and Formaters
      nil
      ruff
      typst
      pyright
      tinymist
      lua-language-server

      # Terminal Utilities
      bc
      jq
      fzf
      git
      zip
      gcc
      tmux
      btop
      wget
      pass
      unzip
      conda
      img2pdf
      pamixer
      ripgrep
      starship
      man-pages
      diff-so-fancy
      brightnessctl
      docker-compose
      man-pages-posix

      # Applications
      feh
      vlc
      vial
      dmenu
      kitty
      pinta
      slides
      chezmoi
      zathura
      obs-studio
      qutebrowser
      inputs.neovim-nightly-overlay.packages.${pkgs.system}.default

      # Communication
      discord
      zoom-us
      telegram-desktop

      # Gaming
      polymc
      mangohud
      protonup

      # Screenshoting Utils
      slop
      xclip
      shotgun
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
