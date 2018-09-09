# moveEditedPhotos
Move edited photos and related files to a backup directory.

While the name says "moveEditedPhotos" this can be applied to any pair of files with matching filenames with differing extensions.

## Usage
The basic usage is this:
./copy_matching_files.sh [-hv] [-d input_dir] [-e ext1] [-f ext2] [-o out_dir]

Flags:
*-h will display the help for the `copy_matching_files` script
*-v will put the script in Verbose mode, letting you know what it's doing
*-d [input_dir] specifies the input directory where the script will look for files
*-e the extension of the files you wish to match on in the input directory, ex: .orf, .jpg, .png, etc.
*-f the extension of the matching files, ex: .xmp
*-o the output directory where the files will be copied to


So long as the script finds a file in directory **input_dir** that has extension **ext1** and it finds a matching filename with extension **ext2**, it will then copy both the original and matched files to the directory **out_dir**.

Note: This has only been tested on macOS using iTerm 2. 