{
  description = "System configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    xremap-flake.url = "github:xremap/nix-flake";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      configs = import ./configs.nix;
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${configs.system};
    in {
      nixosConfigurations = {
        ${configs.hostname} = lib.nixosSystem {
          inherit (configs) system;
          modules = [ ./hosts/${configs.hostname}/configuration.nix ];
          specialArgs = { inherit inputs configs; };
        };
      };
      homeConfigurations = {
        ${configs.username} = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./hosts/${configs.hostname}/home.nix ];
          extraSpecialArgs = { inherit inputs configs; };
        };
      };
    };
}
