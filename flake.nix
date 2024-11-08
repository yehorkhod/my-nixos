{
  description = "System configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    zen-browser.url = "github:MarceColl/zen-browser-flake";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};
    in 
    {
      nixosConfigurations = {
        lemon = lib.nixosSystem {
          inherit system;
          modules = [ ./hosts/lemon/configuration.nix ];
          specialArgs = { inherit inputs; };
        };
      };
      homeConfigurations = {
        yehorkhod = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./hosts/lemon/home.nix ];
        };
      };
  };
}
