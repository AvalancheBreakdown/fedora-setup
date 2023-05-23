#!/bin/bash

HEIGHT=20
WIDTH=90
CHOICE_HEIGHT=4
BACKTITLE="Choose installation Flatpak method"
TITLE="Please Make a selection"
MENU="Please Choose one of the following Desktop Environments:"

OPTIONS=(1  "User"
         2  "System"
         3  "Quit")

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
            flatpak remote-add --if-not-exists flathub https://flathub.org/repo/    flathub.flatpakrepo
            flatpak update
            source flatpak-install.sh
            notify-send "Flatpak (System) has now been enabled" --expire-time=10
            ;;
        2)  echo "Installing Flatpak as User"
            flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/    flathub.flatpakrepo
            flatpak update
            source flatpak-install-user.sh
            notify-send "Flatpak (User) has now been enabled" --expire-time=10
            ;;
       3)
          exit 0
          ;;
     esac
 done
