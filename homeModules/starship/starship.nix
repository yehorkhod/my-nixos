{ config, pkgs, ... }:

{
  programs.starship = {
    enable = true;
    settings = {
      format = ''
        $directory$nix_shell$git_branch$git_status
        $character
      '';

      nix_shell = {
        format = "[ ](bold purple) ";
        style = "bright-purple";
      };
      directory = {
        read_only = " ";
        truncate_to_repo = false;
        style = "italic bright-pink";
      };
      git_branch = {
        symbol = " ";
      };
      character = {
        success_symbol = "[λ](bold green) ";
        error_symbol = "[λ](bold red) ";
      };
    };
  };
}
