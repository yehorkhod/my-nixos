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
      username = configs.username;
      hostname = configs.hostname;
      system = configs.system;

      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};
    in 
    {
      nixosConfigurations = {
        ${hostname} = lib.nixosSystem {
          inherit (configs) system;
          modules = [ ./hosts/${hostname}/configuration.nix ];
          specialArgs = { inherit inputs username hostname; };
        };
      };
      homeConfigurations = {
        ${username} = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./hosts/${hostname}/home.nix ];
          extraSpecialArgs = { inherit inputs username; };
        };
      };
  };
}
