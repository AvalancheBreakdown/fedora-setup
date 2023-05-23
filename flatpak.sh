#!/bin/bash

HEIGHT=20
WIDTH=90
CHOICE_HEIGHT=4
BACKTITLE="Choose Flatpak Installation method"
TITLE="Please Make a selection"
MENU="Please Choose one of the following Desktop Environments:"

OPTIONS=(1  "System"
         2  "User"
         3  "Quit")

# transfer all entries in file to variable
PACKAGES=$(cat flatpak-packages.txt)

# Check if Flatpak is installed, else install it
if ! flatpak --version > /dev/null 2>&1; then
  sudo dnf -y flatpak
fi

while [ "$CHOICE -ne 4" ]; do
    CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --nocancel \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)
clear
     case $CHOICE in
        1)  echo "Installing Flatpak as System"

            # Add remote
            sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
            flatpak update

            # Install the packages using flatpak
            for PACKAGE in $PACKAGES; do
                flatpak install --system -y $PACKAGE
            done

            notify-send "Flatpak (System) has now been enabled" --expire-time=10
            ;;
        2)  echo "Installing Flatpak as User"

            # Add remote
            flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo --user
            flatpak update

            # Install the packages using flatpak
            for PACKAGE in $PACKAGES; do
                flatpak install --user -y $PACKAGE
            done

            notify-send "Flatpak (User) has now been enabled" --expire-time=10
            ;;
       3)
          exit 0
          ;;
     esac
 done
