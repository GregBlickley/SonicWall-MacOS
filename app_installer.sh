#!/bin/bash

#Variables
appName="SonicWall Mobile Connect.app"
tempDir="$HOME/Downloads/SonicWall-Temp"
$gitInst="https://github.com/GregBlickley/SonicWall-MacOS/raw/main/Sonicwall_VD.dmg"
$dmgFile="Sonicwall_VD.dmg"
$dmgName="Sonicwall_VD"

# download .dmg
echo "downloading application file"
curl "$gitInst" -o "$tempDir/$dmgFile"

# confirm download of .dmg
if [ $? != 0 ]; then
    echo "download failed."
    exit 1
fi
echo "download successful."

# mount the .dmg
echo "attaching to virtual drive"
hdiutil attach "$tempDir/$dmgFile"

# move application stored in .dmg to applications
echo "moving application contents"
mv "/Volumes/$dmgName/$appName"

# unmount the .dmg
echo "detaching from virtual drive"
hdiutil detach "/Volumes/$dmgName"

# remove the .dmg file from device
echo "removing excess install files."
rm -r "$tempDir/$dmgFile"