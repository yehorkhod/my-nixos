eval "$(starship init bash)"
export EDITOR=nvim

set -o vi

alias :q="exit"
alias fd="pilot"
alias edit=$EDITOR

alias gs="git status"
alias gp="git push"
alias gc="git commit"
alias ga="git add --patch"
alias gd="git diff --output-indicator-new=' ' --output-indicator-old=' '"
alias gl="git log --all --graph --pretty=format:'%C(magenta)%h %C(white) %an %ar%C(auto) %D%n%s%n'"

export FZF_DEFAULT_OPTS="
  --color=fg:#908caa,bg:#232136,hl:#ea9a97
  --color=fg+:#e0def4,bg+:#393552,hl+:#ea9a97
  --color=border:#44415a,header:#3e8fb0,gutter:#232136
  --color=spinner:#f6c177,info:#9ccfd8
  --color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa"


get_directories() {
  echo "$HOME"
  echo "$HOME/System"
  echo "$HOME/Desktop/Notes"
  find "$HOME/Desktop/Coding" -mindepth 1 -maxdepth 1 -type d 2>/dev/null
  find "$HOME/exercism" -mindepth 1 -maxdepth 1 -type d 2>/dev/null
}
connect_to_session() {
  local session_name="$1"
  if [ -n "$TMUX" ]; then
    tmux switch-client -t "$session_name"
  else 
    tmux attach-session -t "$session_name"
  fi
}
fd() {
  local selected_directory=$(get_directories | fzf \
    --prompt="Choose a destination: " \
    --height=10 \
    --border \
    --reverse)
  if [ -n "$selected_directory" ]; then
    local session_name=$(basename "$selected_directory")
    [[ $session_name == .* ]] && session_name="_${session_name:1}"
    if tmux list-sessions 2>/dev/null | grep -q "^$session_name:"; then
      connect_to_session "$session_name"
    else
      tmux new-session \
        -d \
        -s "$session_name" \
        -c "$selected_directory"
      connect_to_session "$session_name"
    fi
  else
    echo "No directory selected. Exiting."
  fi
}
