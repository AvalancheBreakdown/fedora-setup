#!/bin/bash

HEIGHT=20
WIDTH=90
CHOICE_HEIGHT=4
BACKTITLE="DE Chooser"
TITLE="Please Make a selection"
MENU="Please Choose one of the following Desktop Environments:"

OPTIONS=(1  "KDE Plasma"
         2  "GNOME"
         3  "XFCE"
         4  "Budgie"
         5  "Sway"
         6  "LXDE"
         7  "LXQT"
         8  "Cinnamon"
         9  "Mate"
         10 "Deepin"
         11 "i3"
         12 "Quit")

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
        1)  echo "Installing KDE Plasma"
            sudo dnf install -y @kde-desktop fedora-release-kde
           ;;
#        )  echo ""
#            sudo dnf install -y
#            notify-send "installed" --expire-time=10
#           ;;

        2)  echo "Installing GNOME"
            sudo dnf install -y @gnome-desktop fedora-release-workstation
           ;;

        3)  echo "Installing XFCE"
            sudo dnf install -y @xfce
           ;;
        4)  echo "Installing Budgie"
            sudo dnf install -y @budgie
           ;;
        5)  echo "Installing Sway"
            sudo dnf install -y @sway
           ;;
        6)  echo "Installing LXDE"
            sudo dnf install -y @lxde
           ;;
        7)  echo "Installing LXQT"
            sudo dnf install -y @lxqt
           ;;
        8)  echo "Installing Cinnamon"
            sudo dnf install -y @cinnamon
           ;;
        9)  echo "Installing Mate with Compiz"
            sudo dnf install -y @mate @compiz
           ;;
       10)  echo "Installing Deepin"
            sudo dnf install -y @deepin-desktop
           ;;
       11)  echo "Installing i3"
            sudo dnf install -y @i3
           ;;
       12)
          exit 0
          ;;
     esac
 done
