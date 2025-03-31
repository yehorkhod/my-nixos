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
    inputs.xremap-flake.nixosModules.default
  ];

  system.stateVersion = "24.05";
  environment.systemPackages = base-packages
    ++ [ pkgs.xclip pkgs.libnotify pkgs.shotgun pkgs.hacksaw pkgs.pavucontrol ];

  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
    windowManager.awesome = {
      enable = true;
      luaModules = with pkgs.luaPackages; [ luarocks luadbi-mysql ];
    };
  };
  services.picom.enable = true;
  services.xremap = {
    withX11 = true;
    userName = username;
    yamlConfig = ''
      modmap:
        - name: main remaps
          remap:
            CapsLock:
              held: Super_L
              alone: esc
    '';
  };
}
