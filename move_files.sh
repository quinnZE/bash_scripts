#!/bin/bash

# Usage: ./mv_files.sh <original_dir> <new_dir> <file_extension_if_any>
# Set variables based on args

ORG_DIR=$1
NEW_DIR=$2
FILE_EXT=$3

printf "\nAttempting to move files in $ORG_DIR to $NEW_DIR\n"

if [ -z "$3" ]
then
	printf "\nMoving any files found in $ORG_DIR\n"
else
	printf "\nOnly moving files with extenstion $FILE_EXT found in $ORG_DIR\n"
fi

# Check that original directory exists. Create new directory if it does not exist
if [ ! -d "$ORG_DIR" ]
then
	printf "\n$ORG_DIR does not exist, exiting\n"
	exit 1
fi

if [ ! -d "$NEW_DIR" ]
then
	printf "\n$NEW_DIR not found, this directory will be created\n"
	mkdir -p $NEW_DIR
fi

# Copy files
for FILE in $ORG_DIR/*$FILE_EXT
do
	FILE_NAME=$(basename $FILE)
	printf "\nMoving $FILE to $NEW_DIR/$FILE_NAME"
	mv $FILE $NEW_DIR/$FILE_NAME
	FILE_COUNT=$($FILE_COUNT+1)
done

printf "\n\nFile moving completed. Moved $FILE_COUNT files from $ORG_DIR to $NEW_DIR\n"
exit 0
