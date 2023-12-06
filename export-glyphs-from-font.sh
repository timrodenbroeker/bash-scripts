#!/bin/bash

# Check if FontForge is installed
if ! command -v fontforge &> /dev/null; then
    echo "FontForge is not installed. Please install it first."
    exit 1
fi

# Check if a font file is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <font_file>"
    exit 1
fi

# Set the font file and output directory
font_file="$1"
output_dir="glyph_svgs"

# Create the output directory if it doesn't exist
mkdir -p "$output_dir"

# Use FontForge to export each glyph to an SVG file
fontforge -lang=py -c "
import fontforge
font = fontforge.open('$font_file')
for glyph in font.glyphs():
    glyph.export('$output_dir/' + glyph.glyphname + '.svg')
"

echo "SVG files exported to: $output_dir"
