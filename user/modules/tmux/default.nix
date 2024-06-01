{ ... }:


{
  programs.tmux = {
    enable = true;
    prefix = "C-a";
    terminal = "xterm-256color";
    extraConfig = ''
# Reload hotkey
#bind r source-file ~/.tmux.conf \; display-message "Config reloaded..."

# Unbind
      unbind C-v
      unbind C-b
      unbind '"'
      unbind %

# Window splitting
      bind | split-window -h
      bind - split-window -v


# Do not exit after killing window
      set-option -g detach-on-destroy off

# TermType
#      set-option -sa terminal-overrides ",*256col*:Tc"
      set-option -sg escape-time 10
      set-option -g focus-events on

# switch prefix to control-a, unmap b, allow double-a to go through
      set -g prefix C-a
      bind C-a send-prefix

# Mouse mode
      setw -g mouse on

# CheatSheat
bind-key i run-shell "tmux neww ~/Projects/Shell/fzfcht.sh -t"

# Copy to clipboard
      set-option -s set-clipboard on
      bind-key -T copy-mode-vi Enter send-keys -X copy-pipe-and-cancel 'xclip -se c -i'
      bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel-no-clear 'xclip -se c -i'

# vim style through resizing
      bind -r H resize-pane -L 5
      bind -r J resize-pane -D 5
      bind -r K resize-pane -U 5
      bind -r L resize-pane -R 5


# Window jumping
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

# loud or quiet?
      set -g visual-activity off
      set -g visual-bell off
      set -g visual-silence off
      setw -g monitor-activity off
      set -g bell-action none

# modes
      setw -g clock-mode-colour colour5
      setw -g mode-style 'fg=blue bg=black bold'

# panes
      set -g pane-active-border-style 'bg=#1c1f2b fg=magenta'
      set -g pane-border-style 'fg=magenta'
      set -g pane-border-lines single

# statusbar
      set -g status-position top
      set -g status-justify left 

      set -g status-style 'bg=black fg=white'
      set -g status-left "#[fg=yellow,bg=black,nobold,nounderscore,noitalics]⮑ #[fg=white,bg=black,slant]#h"
      set -g status-right "#[fg=blue]#[bg=black] #(cut -d ' ' -f 1-3 /proc/loadavg) #[fg=yellow,bg=black]#[fg=white,bg=black]|#[fg=yellow,bg=black] %H:%M"
      set -g status-right-length 100
      set -g status-left-length 20

      setw -g window-status-current-style 'fg=blue bg=#1c1f2b bold'
      setw -g window-status-current-format ' #I#[fg=blue]:#[fg=blue]#W#[fg=blue]#F '
      setw -g window-status-format '#I#[fg=white]:#[fg=white]#W#[fg=white]#F '
      setw -g window-status-bell-style 'fg=white bg=black
      '';
  };
}
