{ pkgs, inputs, ... }:

{
  environment.systemPackages =
    with pkgs;
    let
      tex = (
        pkgs.texlive.combine {
          inherit (pkgs.texlive) scheme-basic latexmk xetex;
        }
      );
      pilot = inputs.pilot.packages.${pkgs.system}.pilot;
      cursor = inputs.cursor.packages.${pkgs.system}.default;
      neovim = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    in
    [
      # LSPs and Formaters
      nil
      ruff
      pyright
      lua-language-server

      # Terminal Utilities
      bc
      jq
      tex
      fzf
      git
      zip
      gcc
      tmux
      btop
      wget
      pass
      pilot
      unzip
      conda
      ripgrep
      starship
      diff-so-fancy
      brightnessctl
      docker-compose

      # Applications
      feh
      vlc
      vial
      dmenu
      kitty
      pinta
      slides
      polybar
      chezmoi
      zathura
      obs-studio
      qutebrowser
      libreoffice-qt

      # Communication
      discord
      zoom-us
      telegram-desktop

      # Sound control
      pamixer
      alsa-utils
      alsa-tools
      pavucontrol

      # Editors
      helix
      neovim
      cursor

      # Gaming
      polymc
      mangohud
      protonup

      # Screenshoting Utils
      slop
      xclip
      shotgun
    ];
}
