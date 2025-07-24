{ pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs;
    let
      tex = (pkgs.texlive.combine {
        inherit (pkgs.texlive) scheme-basic latexmk xetex;
      });
      pilot = (callPackage ./pilot/default.nix { inherit pkgs; });
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
      slop
      tmux
      btop
      vial
      wget
      pass
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
      docker-compose
      libreoffice-qt
      telegram-desktop
    ];
}
