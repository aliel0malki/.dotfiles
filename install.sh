#!/usr/bin/env bash

for dir in */ ; do
    if [[ "$dir" == ".git/" ]]; then
        continue
    fi

    echo "Stowing $dir..."
    stow "$dir"
done

echo "All directories stowed successfully."
