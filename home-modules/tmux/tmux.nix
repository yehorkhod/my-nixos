{ ... }:

{
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    prefix = "C-n";
    extraConfig = ''
      set -g default-terminal "tmux-256color"
      set -sg escape-time 0
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R
    '';
  };
}
