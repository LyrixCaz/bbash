# Eden Workstation's Janitor Worker v0.1 by Danny LyriCa
# Janitor LV 0
##################################
# Personal House Keeping
# rm ~/*.log *.png .bash_history

# Torrents
rm ~/.config/transmission-daemon/torrents/*.torrent
rm ~/.config/transmission/torrents/*.torrent

# General House Keeping
rm -rdir --recursive -f ~/.cache
rm -rf --recursive  -f ~/.local/share/Trash

# Wine association cleanup
rm ~/.local/share/applications/wine-ext*
