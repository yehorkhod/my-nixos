# ----------------------------------------------------------------
# ---------------------------- Paths -----------------------------
# ----------------------------------------------------------------
CONFIG_DIRECTORY="$HOME/.config/.pilot"
DESTINATIONS_FILE="$CONFIG_DIRECTORY/destinations.txt"

# Ensure config directory and destinations file exist
mkdir -p "$CONFIG_DIRECTORY"
touch "$DESTINATIONS_FILE"

# ----------------------------------------------------------------
# ---------------------------- Utils -----------------------------
# ----------------------------------------------------------------
# To check if the destinations file is empty
check_destinations_file() {
  if [ ! -s "$DESTINATIONS_FILE" ]; then
    echo "No destinations found. Add directories first with 'pilot add <path>'."
    exit 1
  fi
}

# To find a directory using fzf
fuzzy_find_directory() {
  local message="$1"

  cat "$DESTINATIONS_FILE" | fzf \
    --prompt="$message" \
    --height=10 \
    --border \
    --reverse
}

# To connect to a session regardless of whether user is in tmux or not
connect_to_session() {
  local session_name="$1"

  if [ -n "$TMUX" ]; then
    tmux switch-client -t "$session_name"
  else
    tmux attach-session -t "$session_name"
  fi
}

# ----------------------------------------------------------------
# -------------------------- Functions ---------------------------
# ----------------------------------------------------------------
# To select a destination directory and start a session in it
select_destination() {
  check_destinations_file
  local selected_directory=$(
    fuzzy_find_directory "Choose a destination: "
  )

  # Check if a directory was selected
  if [ -n "$selected_directory" ]; then
    local session_name=$(basename "$selected_directory")

    # Check if a session with the same name already exists
    if tmux list-sessions | grep -q "^$session_name:"; then
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

# To add a directory to the list of destinations
add_destination() {
  local directory_to_add=$(realpath "$1")

  # Check if directory is already in the destinations file
  if grep -Fxq "$directory_to_add" "$DESTINATIONS_FILE"; then
    echo "Already there!"
  else
    echo "$directory_to_add" >> "$DESTINATIONS_FILE"
    echo "Added directory: $directory_to_add"
  fi
}

# To remove a directory from the list of destinations
remove_destination() {
  check_destinations_file
  local directory_to_remove=$(
    fuzzy_find_directory "Choose a directory to remove: "
  )

  # Check if a directory was selected
  if [ -n "$directory_to_remove" ]; then
    # Remove the selected directory from the destinations file
    sed -i "\|$directory_to_remove|d" "$DESTINATIONS_FILE"
    echo "Removed directory: $directory_to_remove"
  else
    echo "No directory selected. Exiting."
  fi
}

# To list all directories in the destinations file
list_destinations() {
  check_destinations_file
  cat "$DESTINATIONS_FILE" | nl -w2 -s': '
}

show_help() {
  echo "Usage:"
  echo "  pilot:             Start a session in a directory"
  echo "  pilot add <path>:  Add a directory to the list of destinations"
  echo "  pilot rm:          Remove a directory from the list of destinations"
  echo "  pilot list:        List all destinations"
}

invalid_command() {
  echo "Invalid command. See 'pilot --help' for usage."
  exit 1
}

# ----------------------------------------------------------------
# ----------------------------- Main -----------------------------
# ----------------------------------------------------------------
case "$1" in
  "")      select_destination    ;;
  add)     add_destination "$2"  ;;
  rm)      remove_destination    ;;
  list)    list_destinations     ;;
  --help)  show_help             ;;
  *)       invalid_command       ;;
esac
