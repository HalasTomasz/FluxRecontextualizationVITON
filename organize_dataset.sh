#!/bin/bash

# Download the ZIP file
wget "https://www.dropbox.com/scl/fi/xu08cx3fxmiwpg32yotd7/zalando-hd-resized.zip?rlkey=ks83mdv2pvmrdl2oo2bmmn69w&dl=1" -O zalando-hd-resized.zip

# Unzip the file
unzip zalando-hd-resized.zip

# Name of the main dataset folder

DATASET_DIR="dataset"

# Create the dataset folder if it doesn't exist
if [ ! -d "$DATASET_DIR" ]; then
    mkdir "$DATASET_DIR"
    echo "Created folder: $DATASET_DIR"
else
    echo "Folder $DATASET_DIR already exists."
fi

# Create subfolders train and test in the dataset folder if they don't exist
for SUBFOLDER in train test; do
    if [ ! -d "$DATASET_DIR/$SUBFOLDER" ]; then
        mkdir -p "$DATASET_DIR/$SUBFOLDER"
        echo "Created folder: $DATASET_DIR/$SUBFOLDER"
    else
        echo "Folder $DATASET_DIR/$SUBFOLDER already exists."
    fi
done

for DATAFOLDER in train test; do
    if [ -d "$DATAFOLDER" ]; then
        echo $DATAFOLDER
        echo $DATASET_DIR/$DATAFOLDER

        rsync -av --remove-source-files "$DATAFOLDER/" "$DATASET_DIR/$DATAFOLDER/"

        if [ "$(ls -A $DATAFOLDER)" ]; then
            echo "Directory $DATAFOLDER was not empty after move."
        else
            # If the directory is now empty, remove the source directory
            rmdir "$DATAFOLDER"
            echo "Removed empty source directory: $DATAFOLDER"
        fi
        echo "Moved contents of $DATAFOLDER to $DATASET_DIR/$DATAFOLDER/"
    else
        echo "Source subfolder $DATAFOLDER not found. Please check the path."
    fi
done



rm zalando-hd-resized.zip
rm test
rm train
rm test_pairs.txt 
rm train_pairs.txt 

echo "Process completed."

