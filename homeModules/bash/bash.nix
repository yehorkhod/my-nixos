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
      "py" = "conda activate $1; venv; pypath";
      "pypath" = "export PYTHONPATH=$(pwd)";
      "numa" = "for a in /sys/bus/pci/devices/*; do echo 0 | sudo tee -a $a/numa_node; done";
      "cpu" = "sudo ${directory}/scripts/cpu_performance.sh";
      "checkout" = "${directory}/scripts/checkout.sh";
      "fd" = "${directory}/scripts/navigate.sh";
    };
  };
} 