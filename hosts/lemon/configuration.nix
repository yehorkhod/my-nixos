{ config, pkgs, inputs, configs, ... }:

let
  username = configs.username;
  base-packages = import ../../nixos-modules/packages.nix { inherit pkgs; };
in {
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
    ../../nixos-modules/programs.nix
    ../../nixos-modules/session-variables.nix
  ];

  system.stateVersion = "24.05";
  environment.systemPackages = base-packages ++ [
    pkgs.grim
    pkgs.slurp
    pkgs.waybar
    pkgs.dunst
    pkgs.wl-clipboard
    pkgs.swaylock
    pkgs.swaynotificationcenter
    pkgs.swaybg
    pkgs.rofi-wayland
    pkgs.libnotify
    pkgs.swappy
    pkgs.light
    pkgs.imagemagick
  ];

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
    desktopManager.gnome.enable = true;
  };
}
