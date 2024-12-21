{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation {
  pname = "pilot";
  version = "1.0.0";

  src = ./.;

  buildInputs = [
    pkgs.fzf
    pkgs.tmux
  ];

  installPhase = ''
    mkdir -p $out/bin
    cp pilot $out/bin/pilot
  '';
}
