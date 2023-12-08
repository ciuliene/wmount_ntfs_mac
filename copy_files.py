import os
import sys
from argparse import ArgumentParser


def get_arguments():
    parser = ArgumentParser(
        description='Copy files from one folder to another')
    parser.add_argument('source', help='Source folder')
    parser.add_argument('destination', help='Destination folder')

    args = parser.parse_args()

    if os.path.isdir(args.source) is False:
        parser.error(f"Source folder '{args.source}' does not exist")

    if os.path.isdir(args.destination) is False:
        parser.error(f"Destination folder '{args.destination}' does not exist")

    return args


def copy_with_progress(src_folder, dest_folder):
    files = os.listdir(src_folder).sort()

    if not os.path.exists(dest_folder):
        os.makedirs(dest_folder)

    for file_name in files:
        src_path = os.path.join(src_folder, file_name)
        dest_path = os.path.join(dest_folder, file_name)

        if os.path.exists(dest_path):
            print(f"File '{file_name}' already exists, skip...")
            continue

        if os.path.isdir(src_path):
            print(f"'{file_name}' is a directory, skip...")
            continue

        file_size = os.path.getsize(src_path)
        copied = 0

        # Open the source and destination files in binary mode and copy each chunk
        with open(src_path, 'rb') as src_file, open(dest_path, 'wb') as dest_file:
            while True:
                chunk = src_file.read(4096)
                if not chunk:
                    break

                dest_file.write(chunk)

                # Print the progress bar
                copied += len(chunk)
                progress = min(int(copied / file_size * 50), 50)
                sys.stdout.write(f'\r{file_name} ')
                sys.stdout.write("[%-50s] %d%%" %
                                 ('=' * progress, progress * 2))
                sys.stdout.flush()
        print()


if __name__ == '__main__':
    args = get_arguments()
    source_folder = args.source
    destination_folder = args.destination

    copy_with_progress(source_folder, destination_folder)
