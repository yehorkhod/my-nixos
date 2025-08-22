{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    polymc.url = "github:PolyMC/PolyMC";
    cursor.url = "github:omarcresp/cursor-flake/main";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      lib = nixpkgs.lib;
      username = "yehorkhod";
      hostname = "grapefruit";
      system = "x86_64-linux";
    in
    {
      nixosConfigurations = {
        ${hostname} = lib.nixosSystem {
          inherit system;
          modules = [ ./configuration.nix ];
          specialArgs = { inherit inputs username hostname; };
        };
      };
    };
}
