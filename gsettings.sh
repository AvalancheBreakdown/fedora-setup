# View current settings - gsettings list-recursively org.gnome.desktop.interface
#Font Settings
gsettings set org.gnome.desktop.interface document-font-name 'Fira Sans Regular 12'
gsettings set org.gnome.desktop.interface font-name 'Fira Sans Regular 12'
gsettings set org.gnome.desktop.interface monospace-font-name 'JetBrainsMono Nerd Font Medium 12'
gsettings set org.gnome.desktop.wm.preferences titlebar-font 'Fira Sans Bold 12'

# Other Settings
gsettings set org.gnome.desktop.interface clock-format '24h'
gsettings set org.gnome.desktop.interface clock-show-date true
gsettings set org.gnome.desktop.interface clock-show-seconds false
gsettings set org.gnome.desktop.interface clock-show-weekday false

# Enable window buttons
#gsettings set org.gnome.desktop.wm.preferences button-layout ":minimize,maximize,close"

# Set new windows centered
gsettings set org.gnome.mutter center-new-windows true
