#!/bin/bash

# Get files from a directory and move or copy them to another directory
# Arguments:
#   -s or --source: source directory
#   -d or --destination: destination directory
#   -m or --move: move files instead of copying them
#   -h or --help: display help message

usage(){
    echo "Usage: copy_files.sh -s|--source <source_dir> -d|--destination <dest_dir> [-m|--move] [-h|--help]"
}

# Parse command line arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -s|--source) source_dir="$2"; shift ;;
        -d|--destination) dest_dir="$2"; shift ;;
        -m|--move) move_files=1 ;;
        -h|--help) help=1 ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

# Display help message
if [[ $help -eq 1 ]]; then
    usage
    exit 0
fi

# Check if source and destination directories are provided
if [[ -z $source_dir ]] || [[ -z $dest_dir ]]; then
    echo "Source and destination directories are required"
    usage
    exit 1
fi

# Check if source directory exists
if [[ ! -d $source_dir ]]; then
    echo "Source directory does not exist"
    exit 1
fi

# Check if destination directory exists
if [[ ! -d $dest_dir ]]; then
    echo "Destination directory does not exist"
    exit 1
fi

files=($source_dir/*)

for ((i=0; i<${#files[@]}; i++)); do
    file="${files[$i]}"

    if [[ $move_files -eq 1 ]]; then
        echo "Moving $file to $dest_dir"
        mv "$file" "$dest_dir"
    else
        echo "Copying $file to $dest_dir"
        cp "$file" "$dest_dir"
    fi
done

echo "Files copied successfully"
