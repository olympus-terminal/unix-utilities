#!/bin/bash

# Find all directories containing 'output' directories with at least 10 subdirectories
find . -mindepth 2 -maxdepth 2 -type d -name "output" -exec sh -c '
    d=$(dirname "$1")
    # Check if the "output" directory has at least 10 subdirectories
    if [ $(find "$1" -mindepth 1 -maxdepth 1 -type d | wc -l) -ge 10 ]; then
        echo "$d"
        # Check if there is a "nest" directory in the parent directory
        if [ -d "$d/nest" ]; then
            # List all subdirectories in the "nest" directory that contain an "output" directory
            subdirs=$(find "$d/nest" -mindepth 1 -maxdepth 1 -type d -name "output")
            for subdir in $subdirs; do
                # Print the path of the "output" directory if it meets the criteria
                echo "$(dirname "$subdir")"
            done
        fi
    fi
' sh {} \; > output.txt
