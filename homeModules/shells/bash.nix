{ config, pkgs, ... }:

let
  directory = ./.;
in
{
  programs.bash = {
    enable = true;
    bashrcExtra = ''
      eval "$(starship init bash)"
    '';
    shellAliases = {
      "venv" = "source venv/bin/activate";
      ":q" = "exit";
      "fm" = "nvim $(fzf)";
      "fd" = "cd $(find ~/A ~/Desktop ~/.config ~/Downloads -type d -print | fzf)";
      "pypath" = "export PYTHONPATH=$(pwd)";
      "spp" = "pypath; venv; tmux";
      "numa" = "for a in /sys/bus/pci/devices/*; do echo 0 | sudo tee -a $a/numa_node; done";
      "cpu" = "sudo ${directory}/scripts/cpu_performance";
    };
  };
} 
