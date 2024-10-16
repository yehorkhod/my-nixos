{ config, pkgs, ... }:

let
  directory = ./.;
in
{
  programs.swaylock = {
    enable = true;
    settings = {
      image = "${directory}/wallpapers/pig.jpg";
    };
  };
}
