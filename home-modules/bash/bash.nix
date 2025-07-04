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
      ":q" = "exit";
      "pypath" = "export PYTHONPATH=$(pwd)";
      "numa" = "for a in /sys/bus/pci/devices/*; do echo 0 | sudo tee -a $a/numa_node; done";
      "cpu" = "sudo ${directory}/scripts/cpu_performance.sh";
      "fd" = "pilot";
      "hm" = "home-manager switch --flake ~/System";
      "nr" = "sudo nixos-rebuild switch --flake ~/System";

      # Git
      "gs" = "git status";
      "gi" = "git add -N";
      "ga" = "git add --patch";
      "gp" = "git push";
      "gur" = "git pull --rebase";
      "gum" = "git pull --merge";
      "gr" = "git rebase";
      "gm" = "git merge";
      "gd" = "git diff --output-indicator-new=' ' --output-indicator-old=' '";
      "gsw" = "git switch";
      "gb" = "git branch";
      "gc" = "git commit";
      "gl" = "git log --all --graph --pretty=format:'%C(magenta)%h %C(white) %an %ar%C(auto) %D%n%s%n'";
      "gst" = "git stash";
    };
  };
}
