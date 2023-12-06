#!/bin/bash

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 input_video.mp4 output.gif"
  exit 1
fi

input_video="$1"
output_gif="$2"

# Check if ffmpeg and ImageMagick are installed
if ! command -v ffmpeg &> /dev/null || ! command -v convert &> /dev/null; then
  echo "ffmpeg and ImageMagick are required. Please install them and try again."
  exit 1
fi

# Convert video to gif with specified properties and a purely black and white dither
ffmpeg -i "$input_video" -vf "fps=15,scale=600:450" -c:v ppm -f image2pipe - | \
  convert - -colors 12 -dither FloydSteinberg -resize 600x450 "$output_gif"

echo "Conversion complete. Output: $output_gif"
