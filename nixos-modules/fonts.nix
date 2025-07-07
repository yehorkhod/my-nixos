{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    corefonts
    vistafonts
    nerd-fonts.iosevka
    nerd-fonts.jetbrains-mono
    nerd-fonts._3270
  ];
}
