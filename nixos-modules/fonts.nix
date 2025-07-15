{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    corefonts
    vistafonts
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts._3270
  ];
}
