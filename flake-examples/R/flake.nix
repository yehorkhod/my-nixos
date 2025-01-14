{
  description = "R Development Flake";

  inputs = { nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          R
          rPackages.tidyverse
          rPackages.countrycode
          rPackages.peacesciencer
          rPackages.tictoc
          rPackages.fastDummies
          rPackages.IRkernel
        ];
      };
    };
}
