{ ... }:

let directory = ./.;
in {
  programs.bash = {
    enable = true;
    bashrcExtra = ''
      eval "$(starship init bash)"
      export MANPAGER='nvim +Man!'
      export EDITOR=nvim
      set -o vi
    '';
    shellAliases = {
      "ty" = "ttyper --language-file ~/System/typing/ttyper-dictionary.txt -w 10"
      "venv" = "source venv/bin/activate";
      ":q" = "exit";
      "py" = "conda activate $1 && venv && pypath";
      "pypath" = "export PYTHONPATH=$(pwd)";
      "numa" =
        "for a in /sys/bus/pci/devices/*; do echo 0 | sudo tee -a $a/numa_node; done";
      "cpu" = "sudo ${directory}/scripts/cpu_performance.sh";
      "co" = "${directory}/scripts/checkout.sh";
      "fd" = "pilot";
    };
  };
}
