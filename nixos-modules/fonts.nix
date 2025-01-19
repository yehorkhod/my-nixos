{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    corefonts
    vistafonts
    (nerdfonts.override { fonts = [ "Iosevka" "JetBrainsMono" "3270" ]; })
  ];
}
