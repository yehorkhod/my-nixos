{ ... }:

let directory = ./.;
in {
  programs.bash = {
    enable = true;
    bashrcExtra = ''
      eval "$(starship init bash)"
      export EDITOR=hx
      set -o vi
    '';
    shellAliases = {
      ":q" = "exit";
      "numa" =
        "for a in /sys/bus/pci/devices/*; do echo 0 | sudo tee -a $a/numa_node; done";
      "cpu" = "sudo ${directory}/scripts/cpu_performance.sh";
      "fd" = "pilot";

      # Git
      "gs" = "git status";
      "gp" = "git push";
      "gc" = "git commit";
      "ga" = "git add --patch";
      "gd" = "git diff --output-indicator-new=' ' --output-indicator-old=' '";
      "gl" =
        "git log --all --graph --pretty=format:'%C(magenta)%h %C(white) %an %ar%C(auto) %D%n%s%n'";
    };
  };
}
