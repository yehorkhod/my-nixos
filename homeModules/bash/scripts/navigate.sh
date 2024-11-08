desktop_directory="$HOME/Desktop"
labs_directory="$HOME/Desktop/labs"
system_dir="$HOME/System"

desktop_directories=$(find "$desktop_directory" -maxdepth 1 -type d -not -path "$desktop_directory")
labs_directories=$(find "$labs_directory" -maxdepth 2 -type d -not -path "$labs_directory")

directories="$desktop_directories"$'\n'"$labs_directories"$'\n'"$system_dir"

selected_dir=$(printf "%s\n" "$directories" | fzf --prompt="Choose a project: " --height=10 --border --reverse)

if [ -n "$selected_dir" ]; then
  session_name=$(basename "$selected_dir")

  cd "$selected_dir" || exit
  tmux new-session -s "$session_name"

  echo "Started a project session in $selected_dir."
else
  echo "No directory selected. Exiting."
fi

