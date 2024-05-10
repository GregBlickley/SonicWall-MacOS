#!/bin/bash

#Variables
appName="SonicWall Mobile Connect.app"
tempDir="$HOME/Downloads/SonicWall-Temp"
$gitInst="https://github.com/GregBlickley/SonicWall-MacOS/blob/main/app_installer.sh"
$dmgFile="Sonicwall_VD.dmg"
$dmgName="Sonicwall_VD"

# download .dmg
curl -sSl "$gitInst" -o "$tempDir/$dmgFile"

# confirm download of .dmg
if [ $? != 0 ]; then
    exit 1
fi

# mount the .dmg
hdiutil attach "$tempDir/$dmgFile"

# move application stored in .dmg to applications
mv "/Volumes/$dmgName/$appName"

# unmount the .dmg
hdiutil detach "/Volumes/$dmgName"

# remove the .dmg file from device
rm -r "$tempDir/$dmgFile"