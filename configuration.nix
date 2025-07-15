{ configs, inputs, ... }:

let stateVersion = configs.stateVersion;
in {
  imports = [
    ./nixos-modules/nix.nix
    ./nixos-modules/boot.nix
    ./nixos-modules/fonts.nix
    ./nixos-modules/users.nix
    ./nixos-modules/locale.nix
    ./nixos-modules/nvidia.nix
    ./nixos-modules/programs.nix
    ./nixos-modules/security.nix
    ./nixos-modules/hardware.nix
    ./nixos-modules/packages.nix
    ./nixos-modules/services.nix
    ./hardware-configuration.nix
    ./nixos-modules/networking.nix
    ./nixos-modules/virtualization.nix
    ./nixos-modules/session-variables.nix
    inputs.xremap-flake.nixosModules.default
  ];
  system.stateVersion = stateVersion;
}
