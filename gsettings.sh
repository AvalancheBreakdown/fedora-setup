# View current settings - gsettings list-recursively org.gnome.desktop.interface
#Font Settings
gsettings set org.gnome.desktop.interface document-font-name 'Fira Sans Regular 12'
gsettings set org.gnome.desktop.interface font-name 'Fira Sans Regular 12'
gsettings set org.gnome.desktop.interface monospace-font-name 'JetBrainsMono Nerd Font Medium 12'
gsettings set org.gnome.desktop.wm.preferences titlebar-font 'Fira Sans Bold 12'

# Icon Themes
gsettings set org.gnome.desktop.interface icon-theme Papirus-Dark

# Other Settings
gsettings set org.gnome.desktop.interface clock-format '24h'
gsettings set org.gnome.desktop.interface clock-show-date true
gsettings set org.gnome.desktop.interface clock-show-seconds false
gsettings set org.gnome.desktop.interface clock-show-weekday false

# Enable window buttons
#gsettings set org.gnome.desktop.wm.preferences button-layout ":minimize,maximize,close"

# Set new windows centered
gsettings set org.gnome.mutter center-new-windows true

# Keybindings
# Unbind
gsettings set org.gnome.desktop.wm.keybindings move-to-monitor-left "[]"
gsettings set org.gnome.desktop.wm.keybindings move-to-monitor-right "[]"
# Bind
gsettings set org.gnome.desktop.wm.keybindings always-on-top "['<Control><Alt>t']"
gsettings set org.gnome.desktop.wm.keybindings close "['<Super>q']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-left "['<Shift><Super>Left']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-right "['<Shift><Super>Right']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "['<Control><Super>Left']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "['<Control><Super>Right']"

