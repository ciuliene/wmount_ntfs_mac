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
