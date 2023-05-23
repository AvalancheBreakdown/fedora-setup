#!/bin/bash

# Script to update hosts file

# Block Lists:
#  1. Base
   bl=https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts
#  2. Base + Porn and Social
   #bl=https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/porn-social/hosts
#  3. Base + Porn
#   bl=https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/porn/hosts


# Check if Internet connection present
function checknet {

j=$(ping -c 1 -q google.com >&/dev/null; echo $?)

if [ $j == 0 ];
then
    checkroot
else
    echo "Offline, quiting"
    exit 1
fi
}

# Check if script has been run as root.
function checkroot {
if [ "$EUID" -ne 0 ]
then
    echo "Run this script as root"
    exit 1
else
    fetch
fi
}

# Download the new hosts file
function fetch {
echo -e "\nDownloading latest file..."
wget $bl -O /etc/hosts
edit
}

# Append Custom List
function edit {
echo -e "Editing....."
echo -e "\n# Custom Blocks" >> /etc/hosts
#echo -e "0.0.0.0 youtube.com\n0.0.0.0 www.youtube.com\n" >> /etc/hosts

echo -e "\nFlushing Caches..."

resolvectl flush-caches

echo -e "\nCompleted"

exit 0

}

# Call first function
checknet

