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
      "venv" = "source venv/bin/activate";
      ":q" = "exit";
      "py" = "conda activate $1 && venv && pypath";
      "pypath" = "export PYTHONPATH=$(pwd)";
      "numa" =
        "for a in /sys/bus/pci/devices/*; do echo 0 | sudo tee -a $a/numa_node; done";
      "cpu" = "sudo ${directory}/scripts/cpu_performance.sh";
      "co" = "${directory}/scripts/checkout.sh";
      "fd" = "pilot";
      "gd" = "git diff --output-indicator-new=' ' --output-indicator-old=' '";
      "gp" = "git push";
      "gu" = "git pull";
      "ga" = "git add --patch";
      "gc" = "git commit";
      "gl" = "git log --all --graph --pretty=format:'%C(magenta)%h %C(white) %an %ar%C(auto) %D%n%s%n'";
      "gs" = "git status";
    };
  };
}
