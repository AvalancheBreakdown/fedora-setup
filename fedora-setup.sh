#!/bin/bash

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin
HEIGHT=20
WIDTH=90
CHOICE_HEIGHT=4
TITLE="Please Make a selection"
MENU="Please Choose one of the following options:"

# Cache Sudo details for later
sudo -v

sudo dnf install -y dialog

OPTIONS=(1 "Enable RPM Fusion - Enables the RPM Fusion repos for your specific version"
         2 "Update Firmware - If your system supports FW update delivery"
         3 "Set sane defaults for dnf"
         4 "Enable Flatpak - choose to enable flatpak for system or user and install packages located in flatpak-packages.txt"
         5 "Select DE"
         6 "Install Software - Enables specified COPRs and installs specified software"
         7 "Update hosts file"
         8 "Install and Set up Fish"
         9 "Install Extras - Themes Fonts and Codecs"
         10 "Set up Rust and Cargo"
         11 "Install the NIX Package manager"
	     12 "Quit")

# Set an unfulfillable argument to run dialog everytime?
while [ "$CHOICE -ne 4" ]; do
    CHOICE=$(dialog --clear \
                --title "$TITLE" \
                --cr-wrap \
                --nocancel \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

    clear
    case $CHOICE in
        1)  echo "Enabling RPM Fusion"
            sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
	        sudo dnf upgrade --refresh
            sudo dnf groupupdate -y core
            sudo dnf install -y rpmfusion-free-release-tainted
            sudo dnf install -y dnf-plugins-core
            notify-send "RPM Fusion Enabled" --expire-time=10
            ;;
        2)  echo "Updating System Firmware"
            sudo fwupdmgr get-devices
            sudo fwupdmgr refresh --force
            sudo fwupdmgr get-updates
            sudo fwupdmgr update
            ;;
        3)  echo "Speeding Up DNF"
            sudo rm /etc/dnf/dnf.conf
            sudo mv "$PWD"/dnf.conf /etc/dnf/dnf.conf
            notify-send "Your DNF config has now been amended" --expire-time=10
            ;;

        4)  echo "Enabling Flatpak"
           ./flatpak.sh
           ;;

        5)  echo "Select your Desktop Environment"
            ./de.sh
            ;;

        6)  echo "Installing Software"
            num_lines=$(cat copr-list.txt | wc -l)
            for (( i=1; i<=num_lines; i++ ))
            do
              line=$(sed -n "${i}p" copr-list.txt)
              sudo dnf copr enable -y "$line"
            done

            sudo dnf update -y
            sudo dnf install -y '$(cat dnf-packages.txt)'
            notify-send "Software has been installed" --expire-time=10
            ;;

        7)  echo "Updating Hosts"
            sudo ./hosts.sh
            ;;

        8)  echo "Set up Fish"
            sudo dnf -y install fish util-linux-user
            chsh -s "$(which fish)"
            curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
            notify-send "Fish ready" --expire-time=10
            ;;

        9) echo "Installing Extras"
            sudo dnf groupupdate -y sound-and-video
            sudo dnf install -y libdvdcss
            sudo dnf install -y gstreamer1-plugins-{bad-\*,good-\*,ugly-\*,base} gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel ffmpeg gstreamer-ffmpeg
            sudo dnf install -y lame\* --exclude=lame-devel
            sudo dnf group upgrade -y --with-optional Multimedia
	        sudo dnf copr enable peterwu/iosevka -y
            sudo -s dnf -y copr enable dawid/better_fonts
            sudo dnf update -y
            sudo -s dnf install -y fontconfig-font-replacements
            sudo -s dnf install -y fontconfig-enhanced-defaults
	        sudo dnf update -y
	        sudo dnf install -y iosevka-term-fonts terminus-fonts terminus-fonts-console google-noto-fonts-common mscore-fonts-all papirus-icon-theme
            sudo wget -qO- https://git.io/papirus-folders-install | sh
            sudo cp -r Extra_Fonts/ /usr/share/fonts
            ./gsettings.sh
            notify-send "All done" --expire-time=10
            ;;
       10)  echo "Seting up cargo"
            sudo dnf install -y rust cargo
            cargo install "$(cat cargo-packages.txt)"
            notify-send "Cargo has been installed" --expire-time=10
            ;;
       11)  echo "Installing Nix"
            sh <(curl -L https://nixos.org/nix/install) --daemon
            notify-send "The Nix Package Manager has been installed" --expire-time=10
	        ;;
       12)
          exit 0
          ;;
    esac
done
