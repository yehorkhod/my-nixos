{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    xremap-flake.url = "github:xremap/nix-flake";
    polymc.url = "github:PolyMC/PolyMC";
    cursor.url = "github:omarcresp/cursor-flake/main";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      lib = nixpkgs.lib;
      username = "yehorkhod";
      hostname = "grapefruit";
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations = {
        ${hostname} = lib.nixosSystem {
          inherit system;
          modules = [ ./configuration.nix ];
          specialArgs = { inherit inputs username hostname; };
        };
      };
    };
}
