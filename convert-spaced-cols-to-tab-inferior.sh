#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 input_file output_file"
    exit 1
fi

if [ ! -f "$1" ]; then
    echo "Error: Input file $1 does not exist."
    exit 1
fi

awk 'BEGIN {OFS="\t"} {$1=$1; print}' "$1" > "$2"

if [ $? -eq 0 ]; then
    echo "Conversion complete. Output written to $2"
else
    echo "Error occurred during conversion."
    exit 1
fi
