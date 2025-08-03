{ pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs;
    let
      tex = (pkgs.texlive.combine {
        inherit (pkgs.texlive) scheme-basic latexmk xetex;
      });
      pilot = inputs.pilot.packages.${pkgs.system}.pilot;
      cursor = inputs.cursor.packages.${pkgs.system}.default;
    in [
      bc
      jq
      tex
      git
      vlc
      zip
      fzf
      feh
      nil
      slop
      tmux
      btop
      vial
      wget
      pass
      ruff
      conda
      kitty
      pilot
      helix
      pinta
      unzip
      xclip
      dmenu
      slides
      cursor
      libgcc
      polymc
      pyright
      shotgun
      polybar
      discord
      zoom-us
      pamixer
      ripgrep
      zathura
      chezmoi
      mangohud
      protonup
      starship
      neofetch
      alsa-utils
      alsa-tools
      obs-studio
      pavucontrol
      qutebrowser
      brightnessctl
      diff-so-fancy
      nixfmt-classic
      docker-compose
      libreoffice-qt
      telegram-desktop
    ];
}
