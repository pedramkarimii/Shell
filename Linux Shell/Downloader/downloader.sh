#! /bin/bash

# Check if URL argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <URL>"
    exit 1
fi

# Download the file using wget and follow redirects
# -P specifies the directory prefix where all files will be saved
# -L instructs wget to follow redirects
wget -P ~/Desktop/python/HW/HW9/Downloader/ -L "$1"

# Check if download was successful
if [ $? -eq 0 ]; then
    # If successful, append the file link to txt.log
    echo "File downloaded successfully - $1" >> ~/Desktop/python/HW/HW9/Downloader/txt.log
else
    # If unsuccessful, append an error message to txt.log
    echo "Error downloading file - $1" >> ~/Desktop/python/HW/HW9/Downloader/txt.log
fi

