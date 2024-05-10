#!/bin/bash

#Variables
appName="SonicWall Mobile Connect.app"
tempDir="$HOME/Downloads/SonicWall-Temp"
$gitInst="url/download"

# check to see if the application exists
if ls /Application | grep -qi "$appName"; then

    # if it exists exit 0
    exit 0

# else
else    
    
    # configure temporary directory
    mkdir -p "$tempDir"
    
    # download the file from GitHub
    curl -sSl "$gitInst" -o "$tempDir/installer.sh"

    # check if the download was successful
    if [ $? != 0 ]; then
        exit 1                  # exit 1 if the download failed
    fi

    # Run the install.sh
    source "$tempDir/installer.sh"

    # wait for the script to finish
    tmp="How do we do this?"

    # Remove the install.sh file
    rm -r "$tempDir"

    # verify that the application was installed
    if ls /Application | grep -qi "$appName"; then
        exit 0
    else
        exit 1
    fi
fi