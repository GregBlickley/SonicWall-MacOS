#!/bin/bash

#Variables
appName="SonicWall Mobile Connect.app"
tempDir="$HOME/Downloads/SonicWall-Temp"
gitInst="https://raw.githubusercontent.com/GregBlickley/SonicWall-MacOS/main/app_installer.sh"

# check to see if the application exists
if ls /Application | grep -qi "$appName"; then

    # if it exists exit 0
    exit 0

# else
else    
    echo "App not installed"
    
    # configure temporary directory
    mkdir -p "$tempDir"
    echo "Temporary directory made."

    # download the file from GitHub
    echo "downloading installer.."
    curl -o "$tempDir/installer.sh" "$gitInst"

    # check if the download was successful
    if [ $? != 0 ]; then
        echo "download failed."
        exit 1                  # exit 1 if the download failed
    fi

    # Run the install.sh
    echo "running installer."
    source "$tempDir/installer.sh"

    # wait for the script to finish
    sleep 1m

    # Remove the install.sh file
    echo "removing temp directory"
    rm -r "$tempDir"

    # verify that the application was installed
    if ls /Application | grep -qi "$appName"; then
        echo "application has been installed."
        exit 0
    else
        exit 1
    fi
fi