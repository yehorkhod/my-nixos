{ config, pkgs, configs, ... }:

let
  theme = configs.theme;
in
{
  programs.helix = {
    enable = true;

    settings = {
      theme = 
        if theme == "rose-pine" then
          "rose_pine"
        else
          "everforest_dark";
      editor = {
        line-number = "relative";
      };
    };
  };
}
