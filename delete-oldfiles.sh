#!/bin/bash
echo "This script deletes files which are older than 30 days"
path="$1"  # Specify the correct path here
echo "Path for deletion: $path"

# Find and delete files older than 30 days
find "$path" -type f -mtime +30 -delete

if [ $? -eq 0 ]; then 
    echo "Files are successfully deleted."
else 
    echo "Deletion was having some issues."
fi
