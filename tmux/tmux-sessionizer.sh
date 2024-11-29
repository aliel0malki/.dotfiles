#!/usr/bin/env bash

# Array of directories to search, adding conditions to ensure they exist
search_dirs=(
    ~/github
    ~/work
    ~/projects
    ~/code
    ~/personal
)

# Filter out directories that don't exist
existing_dirs=()
for dir in "${search_dirs[@]}"; do
    if [[ -d $dir ]]; then
        existing_dirs+=("$dir")
    fi
done

if [[ $# -eq 1 ]]; then
    selected=$1
else
    # Exclude hidden directories and suppress errors for non-existent paths
    selected=$(find "${existing_dirs[@]}" -mindepth 1 -maxdepth 4 -type d 2>/dev/null | grep -v '/\.' | fzf)
fi

if [[ -z $selected ]]; then
    exit 0
fi

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)
if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s $selected_name -c $selected
    exit 0
fi

if ! tmux has-session -t=$selected_name 2> /dev/null; then
    tmux new-session -ds $selected_name -c $selected
fi

tmux switch-client -t $selected_name
