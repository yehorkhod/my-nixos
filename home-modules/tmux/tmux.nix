{ ... }:

{
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    prefix = "C-n";
    keyMode = "vi";
    extraConfig = ''
      set -g default-terminal "tmux-256color"
      set -sg escape-time 0
      bind-key h select-pane -L
      bind-key j select-pane -D
      bind-key k select-pane -U
      bind-key l select-pane -R

      bind-key -T copy-mode-vi 'v' send -X begin-selection
      bind-key -T copy-mode-vi 'y' send -X copy-selection-and-cancel
    '';
  };
}
