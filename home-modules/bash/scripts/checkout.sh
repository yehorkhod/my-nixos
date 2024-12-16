branches=$(git branch -r | sed 's|origin/||' | sort -u)

selected_branch=$(printf "%s\n" "${branches}" | fzf --prompt="Choose a branch to checkout: " --height=10 --border --reverse)

if [ -n "$selected_branch" ]; then
  git checkout $selected_branch
  echo "Checked out to branch $selected_branch"
else
  echo "No branch selected. Exiting."
fi
