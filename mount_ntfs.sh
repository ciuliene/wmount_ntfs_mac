#!/bin/bash

# Install drivers if not installed
# brew tap gromgit/homebrew-fuse
# brew install --cask macfuse
# brew install ntfs-3g-mac 

print_help(){
    echo "Mount NTFS volumes with write enabled"
    echo "Usage: $0 [-u|--unmount] [-h|--help]"
    echo "Options:"
    echo "                     Unmount the NTFS volume and remount it with write access."
    echo "  -r, --read-only    Unmount the NTFS volume and remount it without wtite access."
    echo "  -u, --unmount      Unmount the NTFS volume without remounting with write access."
    echo "  -h, --help         Display this help message."
    exit 1
}

unmount=false
rw=true

while [[ $# -gt 0 ]]; do
    case "$1" in
        -u|--unmount)
        unmount=true
        shift 1
        ;;
        -r|--read-only)
        rw=false
        shift 1
        ;;
        -h|--help)
        print_help
        ;;
    *)
    echo "\033[33mInvalid option\033[0m: $1"
    print_help
    ;;
    esac
done

# Execute the command and capture the output in a variable
disk_list_output=$(diskutil list | grep Windows_NTFS | sed -E 's/.* ([A-Za-z0-9]+)$/\1/')

# Count the number of results
num_disks=$(echo "$disk_list_output" | wc -l | sed -e 's/^[[:space:]]*//')

# If there are multiple disks found, prompt the user to select one
if [ "$num_disks" -gt 1 ]; then
  echo "Multiple Windows_NTFS disks have been found:"
  
  # Enumerate and print the disks with numbers next to them
  indexed_disks=($disk_list_output)
  for ((i=0; i<num_disks; i++)); do
    idx=$((i+1))
    disk_id="${indexed_disks[i]}"
    disk_name=$(diskutil info /dev/$disk_id | grep "Volume Name" | awk '{print $NF}')
    echo "$idx. $disk_id - $disk_name"
  done
  
  echo "Select the desired disk by entering the corresponding number:"
  
  # Read user input
  read selected_disk
  
  # Check if the input is a number and within the range of 1 to the number of disks found
  if ! [[ "$selected_disk" =~ ^[0-9]+$ ]] || ((selected_disk < 1 || selected_disk > num_disks)); then
    echo "Invalid input. Please enter a valid number between 1 and $num_disks."
    exit 1
  fi

  # Extract the selected disk
  selected_disk_name=${indexed_disks[selected_disk-1]}

  # Perform the desired action on the selected disk
  vol_id=$selected_disk_name
else
  # If only one Windows_NTFS disk is found, perform the action directly on it
  echo "Only one Windows_NTFS disk has been found: $disk_list_output"
  vol_id=$disk_list_output
fi

ntfs_disk=/dev/$vol_id

echo $ntfs_disk

VOLUME_NAME=$(diskutil info $ntfs_disk | grep "Volume Name" | awk '{print $NF}')

mount_point="/Volumes/$VOLUME_NAME"

echo "Unmounting \033[33m${VOLUME_NAME}\033[0m..."

diskutil unmount force "$ntfs_disk"

if [ "$unmount" = true ]; then
    exit 1
fi

echo "Remounting \033[33m${VOLUME_NAME}\033[0m with write enabled..."

if [ "$rw" = true ]; then
  sudo mkdir -p "$mount_point"
  sudo ntfs-3g "$ntfs_disk" "$mount_point"
else
  diskutil mount $ntfs_disk 
fi

if [ $? -eq 0 ]; then
    echo "NTFS disk mounted with write enabled in \033[32m$mount_point\033[0m."
else
    echo "\033[31mAn error occurred while mounting the NTFS disk.\033[0m"
fi