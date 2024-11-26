#!/bin/bash

DATASET_DIR="dataset"

SUBFOLDERS=("train" "test")

for SUBFOLDER in "${SUBFOLDERS[@]}"; do
    FOLDER_PATH="$DATASET_DIR/$SUBFOLDER"
    
    if [ -d "$FOLDER_PATH" ]; then
        echo "Processing folder: $FOLDER_PATH"
        find "$FOLDER_PATH" -type f -exec rm -f {} \;
        echo "All files in $FOLDER_PATH and its subfolders have been deleted."
    else
        echo "Folder $FOLDER_PATH does not exist."
    fi
done

echo "Process completed."
