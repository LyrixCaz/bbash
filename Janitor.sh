# Eden Workstation's Janitor Worker 1.0 by Danny LyriCa
# General House Keeping
rm -rf ~/*.log *.png .bash_history
rm -rf ~/.config/transmission-daemon/torrents/*.torrent
rm -rdir --recursive -f ~/.cache .log
rm -rf --recursive  -f ~/.local/share/Trash
# Wine association cleanup
rm -rf ~/.local/share/applications/wine*
rm -rdir ~/.local/share/applications/wine
