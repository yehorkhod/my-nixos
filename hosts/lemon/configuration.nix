{ config, pkgs, inputs, configs, ... }:

let
  username = configs.username;
in
{
  imports = [
    ../../hardware-configuration.nix
    ../../nixos-modules/nvidia.nix
    ../../nixos-modules/boot.nix
    ../../nixos-modules/fonts.nix
    ../../nixos-modules/users.nix
    ../../nixos-modules/networking.nix
    ../../nixos-modules/locale.nix
    ../../nixos-modules/security.nix
    ../../nixos-modules/nix.nix
    ../../nixos-modules/hardware.nix
    ../../nixos-modules/services.nix
    ../../nixos-modules/virtualization.nix
  ];

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

    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
  };

  nixpkgs.config.allowUnfree = true;

  environment = {
    systemPackages = with pkgs;
    let
      tex = (pkgs.texlive.combine
        { inherit (pkgs.texlive) scheme-basic latexmk; });
      pilot = (callPackage
        ../../nixos-modules/pilot/default.nix
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

      # Specifics
      grim slurp waybar dunst wl-clipboard swaylock
      swaynotificationcenter swaybg rofi-wayland
      libnotify swappy light imagemagick
    ];
    sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/${username}/.steam/root/compatibilitytools.d";
      WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";
    };
  };

  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  system.stateVersion = "24.05";
}
