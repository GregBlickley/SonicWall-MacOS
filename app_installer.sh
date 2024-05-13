#!/bin/bash

#Variables
appName="SonicWall Mobile Connect.app"
tempDir="$HOME/Downloads/SonicWall-Temp"
gitInst="https://raw.githubusercontent.com/GregBlickley/SonicWall-MacOS/main/Sonicwall_VD.dmg"
dmgFile="Sonicwall_VD.dmg"
dmgName="Sonicwall_VD"
#encodedURL=encoded_url=$(echo "$gitInst" | sed 's/ /%20/g')
# download .dmg
echo "downloading application file"
curl -o "$tempDir/Sonicwall_VD.dmg" "$gitInst"              # Since the file is over 50MB the application gets lost during this proceess


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
#mv -f "/Volumes/$dmgName/$appName" "/System/Applications"
cp -R "/Volumes/$dmgName/$appName" "/Applications"

# verify that the application was installed
#if ls /System/Applications | grep -qi "$appName"; then
 #   echo "$appName installed successfully."
  #  exit 0
#else
 #   echo "$appName failed to install."
  #  exit 1
#fi

# unmount the .dmg
echo "detaching from virtual drive"
hdiutil detach "/Volumes/$dmgName"

# remove the .dmg file from device
echo "removing excess install files."
rm -r "$tempDir/$dmgFile"
