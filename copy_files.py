import os
import shutil
import argparse
import os
import shutil
import argparse


def copy_files(source_folder, destination_folder):
    for root, _, files in os.walk(source_folder):
        for file in files:
            source_path = os.path.join(root, file)
            destination_path = os.path.join(
                destination_folder, os.path.relpath(source_path, source_folder))
            os.makedirs(os.path.dirname(destination_path), exist_ok=True)
            shutil.copy2(source_path, destination_path)


if __name__ == "__main__":  # pragma: no cover
    parser = argparse.ArgumentParser(
        description="Copy files from a source folder to a destination folder")
    parser.add_argument("source_folder", help="Path to the source folder")
    parser.add_argument("destination_folder",
                        help="Path to the destination folder")
    args = parser.parse_args()

    if not os.path.exists(args.source_folder):
        print("\033[31mThe source folder does not exist\033[0m")
        exit(1)

    if not os.path.exists(args.destination_folder):
        print("\033[31mThe destination folder does not exist\033[0m")
        exit(1)

    copy_files(args.source_folder, args.destination_folder)
