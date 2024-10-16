{ config, pkgs, ... }:

{
  programs.starship = {
    enable = true;
    settings = {
      format = ''
        $nix_shell$directory$git_branch$git_status$cmd_duration
        [λ ](bright-green)
      '';

      nix_shell = {
        symbol = " ";
        style = "bright-purple";
      };
      directory = {
        read_only = " ";
        # truncation_length = 10;
        truncate_to_repo = false;
        style = "italic bright-pink";
      };
      git_branch = {
        symbol = " ";
      };
      cmd_duration = {
        min_time = 0;
        show_milliseconds = true;
        disabled = false;
        style = "bold brigth-red";
      };
    };
  };
}
