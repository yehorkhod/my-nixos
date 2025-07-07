{ pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs;
    let
      tex = (pkgs.texlive.combine {
        inherit (pkgs.texlive) scheme-full latexmk xetex;
      });
      pilot = (callPackage ./pilot/default.nix { inherit pkgs; });
      cursor = inputs.cursor;
    in [
      # Text editors
      neovim
      helix
      cursor.packages.${pkgs.system}.default

      # Communication
      telegram-desktop
      discord
      zoom-us

      # Work
      git
      conda
      docker-compose
      kitty
      alacritty
      tmux
      btop
      pilot

      # Apps
      libreoffice-qt
      vlc
      obs-studio
      pinta
      slides
      qutebrowser
      zathura
      vial

      # Global Utils
      brightnessctl
      zip
      unzip
      bc
      jq
      starship
      fzf
      neofetch
      wget
      alsa-utils
      alsa-tools
      pamixer
      pass
      tex
      ripgrep
      libgcc
      diff-so-fancy
      xclip
      shotgun
      hacksaw
      feh
      dmenu
      polybar
      pavucontrol

      # Games
      polymc
      mangohud
      protonup
    ];
}
