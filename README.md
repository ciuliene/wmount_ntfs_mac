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

There is a python script called `copy_files.py` used to copy files from a folder into another folder (also files in subfolders). Just run:

```bash
python copy_files.py <source_folder> <destination_folder> # Arguments are mandatory
```
