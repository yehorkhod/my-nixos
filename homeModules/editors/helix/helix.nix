{ config, pkgs, ... }:

{
  programs.helix = {
    enable = true;

    settings = {
      theme = "rose_pine";
      editor = {
        line-number = "relative";
        lsp.display-messages = true;
      };
    };
  };
}
