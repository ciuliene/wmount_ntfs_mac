# NTFS for macOS

Shell script for macOs to mount NTFS volumes with write enabled
 
## Requisites

Install drivers if not installed:

```bash
brew tap gromgit/homebrew-fuse
brew install --cask macfuse
brew install ntfs-3g-mac 
```

## Usage

List of commands:

| Description | Command |
|-|-|
|Mount NTFS volume with write enabled | `mount_ntfs.sh` |
|Unmount NTFS volume | `mount_ntfs.sh -u` |
|Mount NTFS volume withou write enabled | `mount_ntfs.sh -r` |
|Show help | `mount_ntfs.sh -h` |

## Extra

There is a shell script called `copy_files.sh` used to copy or move files from a folder into another folder. Just run:

```bash
sh copy_files.sh -s <source_folder> -d <destination_folder> [-m]
```

Where:
- `<source_folder>` is the folder where the files are located
- `<destination_folder>` is the folder where the files will be copied
- `-m` is an optional flag to move the files instead of copying them