import unittest
from unittest.mock import patch
import os
import shutil
from copy_files import copy_files


@patch('shutil.copy2')
@patch('os.path.dirname')
@patch('os.path.relpath')
@patch('os.makedirs')
@patch('os.path.join')
@patch('os.walk')
class FileCopyTests(unittest.TestCase):
    def test_copy_files(self, mock_walk, mock_join, mock_makedirs, mock_relpath, mock_dirname, mock_copy, *_):
        # Arrange
        source = "source"
        destination = "destination"
        files = ["file1.txt", "file2.txt", "file3.txt"]
        sub_files = ["file4.txt", "file5.txt", "file6.txt"]
        mock_walk.return_value = [
            ("source", [], files),
            ("source/subfolder", [], sub_files)
        ]

        # Act
        copy_files(source, destination)

        # Assert
        mock_walk.assert_called_once_with(source)
        self.assertEqual((len(files) + len(sub_files))
                         * 2, mock_join.call_count)
        self.assertEqual(len(files) + len(sub_files), mock_makedirs.call_count)
        self.assertEqual(len(files) + len(sub_files), mock_relpath.call_count)
        self.assertEqual(len(files) + len(sub_files), mock_dirname.call_count)
        self.assertEqual(len(files) + len(sub_files), mock_copy.call_count)


if __name__ == "__main__":
    unittest.main()
