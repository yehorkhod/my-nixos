{ pkgs }:

with pkgs;
let
  tex = (pkgs.texlive.combine
    { inherit (pkgs.texlive) scheme-basic latexmk; });
  pilot = (callPackage
    ./pilot/default.nix
    { inherit pkgs; });
in
[
  # Text editors
  neovim helix jetbrains-toolbox

  # Communication
  telegram-desktop discord zoom-us

  # Work
  git conda docker-compose
  kitty tmux btop pilot

  # Apps
  libreoffice-qt vlc obs-studio
  pinta slides qutebrowser zathura

  # Global Utils
  brightnessctl zip unzip bc
  starship fzf neofetch wget
  alsa-utils alsa-tools pamixer
  pass tex ripgrep libgcc

  # Games
  mangohud protonup
]