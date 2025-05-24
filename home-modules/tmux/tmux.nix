{ ... }:

{
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    prefix = "C-n";
    keyMode = "vi";
    escapeTime = 0;
    mouse = true;
    historyLimit = 10000;
    extraConfig = ''
      set -g default-terminal "tmux-256color"
      set -g renumber-windows on

      bind-key h select-pane -L
      bind-key j select-pane -D
      bind-key k select-pane -U
      bind-key l select-pane -R

      bind-key -T copy-mode-vi 'v' send -X begin-selection
      bind-key -T copy-mode-vi 'y' send -X copy-selection-and-cancel

      set -g status-style bg=default,fg=black,bright
      set -g status-left ""
      set -g status-right "#[fg=magenta,bright]#S"

      set -g window-status-format "●"
      set -g window-status-style "fg=green"
      set -g window-status-current-format "◎"
      set -g window-status-current-style "#{?window_zoomed_flag,fg=yellow,fg=magenta,nobold}"
      set -g window-status-bell-style "fg=red,nobold"

      set -g pane-border-lines simple
    '';
  };
}
