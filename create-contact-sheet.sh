#!/bin/bash

# Check if ImageMagick is installed
if ! command -v convert &> /dev/null; then
    echo "ImageMagick is not installed. Please install it first."
    exit 1
fi

# Check if the folder path is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <folder_path>"
    exit 1
fi

# Set the output PDF file name
output_pdf="contact_sheet.pdf"

# Navigate to the specified folder
cd "$1" || exit 1

# Get a list of image files in the folder
image_files=$(ls *.{png,jpg,jpeg,gif,bmp} 2>/dev/null)

# Check if there are any image files
if [ -z "$image_files" ]; then
    echo "No image files found in the specified folder."
    exit 1
fi

# Create a temporary directory for resized images
temp_dir=$(mktemp -d)

# Resize images to a consistent size
for file in $image_files; do
    convert "$file" -resize 100x100 "$temp_dir/$file"
done

# Calculate the number of images per A4-sized page
images_per_page=3  # You can adjust this value as needed
margin_size=10      # You can adjust this value as needed

# Create a contact sheet using montage with A4-sized pages and margins
montage "$temp_dir"/* -label '%f' -tile 7x7 -geometry +5+5 -border $margin_size -bordercolor white -page A4+${margin_size}+${margin_size} "$output_pdf"

# Clean up temporary directory
rm -r "$temp_dir"

echo "Contact sheet created: $output_pdf"
