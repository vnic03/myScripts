#!/bin/bash

# Backup Script
# This script backs up specified directories or files to a backup directory with a timestamp for versioning.

# Define the directories or files to backup
SOURCE_DIRECTORIES=(
    "/path/to/first_directory"
    "/path/to/second_directory"
    # Add more directories or files as needed
)

# Define the backup directory
BACKUP_DIRECTORY="/path/to/backup_directory"

mkdir -p "$BACKUP_DIRECTORY"

# Get the current date and time for the timestamp
TIMESTAMP=$(date +"%Y%m%d%H%M%S")

function backup {
    for SOURCE in "${SOURCE_DIRECTORIES[@]}"; do
        BASENAME=$(basename "$SOURCE")
        BACKUP_DEST="$BACKUP_DIRECTORY/${BASENAME}_$TIMESTAMP"
        rsync -avh --progress "$SOURCE" "$BACKUP_DEST"
    done
}

backup

echo "Backup completed at $TIMESTAMP. Files have been copied to $BACKUP_DIRECTORY."
