#!/bin/bash

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 input.gif output.gif"
  exit 1
fi

input_file="$1"
output_file="$2"

# Check if ImageMagick is installed
if ! command -v convert &> /dev/null; then
  echo "ImageMagick is not installed. Please install it and try again."
  exit 1
fi

# Convert GIF to black and white using Floyd-Steinberg diffusion
convert "$input_file" -ordered-dither o8x8,50% -colors 12 "$output_file"

echo "Conversion complete. Output: $output_file"
