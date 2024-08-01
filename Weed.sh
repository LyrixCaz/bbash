#!/bin/bash
#####	 WIP	#####

# Interactive script for system setup for openSUSE [Tumbleweed]
# get realtimequickscan package to help with music tweaks
# For No SWAP do:
# 	 sudo zypper in systemd-zram-service
#	systemctl enable --now zramswap.service 


sed '/GRUB_CMDLINE_LINUX_DEFAULT=/i GRUB_CMDLINE_LINUX_DEFAULT=threadirqs'  /etc/default/grub # This is how it will look

touch /etc/security/audio.conf
echo "@audio   -  rtprio     95" >>  /etc/security/audio.conf
echo "@audio   -  memlock    unlimited" >>  /etc/security/audio.conf

touch /etc/sysctl.conf
echo "vm.swappiness = 10" >> /etc/sysctl.conf
echo "fs.inotify.max_user_watches = 524288" >> /etc/sysctl.conf
echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
echo "net.ipv6.conf.default.disable_ipv6 = 1 " >> /etc/sysctl.conf
echo "net.ipv6.conf.lo.disable_ipv6 = 1" >> /etc/sysctl.conf

touch /etc/udev/rules.d/cpu-dma-latency.rules
echo DEVPATH=="/devices/virtual/misc/cpu_dma_latency", OWNER="root", GROUP="audio", MODE="0660" >>  /etc/udev/rules.d/cpu-dma-latency.rules
touch /etc/udev/rules.d/40-timer-permissions.rules
echo "KERNEL=="rtc0", GROUP="audio"" >>  /etc/udev/rules.d/40-timer-permissions.rules
echo "KERNEL=="hpet", GROUP="audio"" >>  /etc/udev/rules.d/40-timer-permissions.rules
# Reload and trigger udev rules with:
# udevadm control --reload-rules && udevadm trigger
gpasswd -a $USER -g audio
gpasswd -a $USER -g video

# Lock, Unlock, Remove
zypper rm -u *gvfs*
zypper al *gvfs*
zypper rm xwaylandvideobridge
zypper al xwaylandvideobridge
zypper rm *bash-completion
zypper al *bash-completion
zypper rm *-lang
zypper al *-lang
zypper rm *vlc*
zypper al *vlc*
zypper rm -u nano
zypper al plasma6-print-manager kleopatra *PackageKit*

# Audiotunes
update-bootloader --refresh # Updates/Refreshes Grub
export $ME=aniki

####
# ZypperWorks
zypper refresh
zypper dup
sed -i '/# installRecommends = yes/a installRecommends = no' /etc/zypp/zypper.conf # No recommends

# The Programs: # Admin stuff+
zypper in --recommends tmux nmap iperf wireshark-ui-qt busybox-net-tools traceroute speedtest-cli rpi-imager systemd-zram-service tree
gpasswd -a $ME -g wireshark
zypper in --recommends podman qemu libvirt virt-manager
gpasswd -a $ME -g libvirt
systemctl enable libvirtd
zramswapon

curl -fsSL https://tailscale.com/install.sh | sh # tailscale
zypper mr -p98 -r tailscale-stable
zypper dup --allow-vendor-change

# The programs+
zypper in neofetch vim
zypper in --recommends gnome-disk-utility hugo git-core keepassxc MozillaFirefox MozillaThunderbird transmission-qt mpv libvulkan_intel-32bit libvulkan_radeon libvulkan_radeon-32bit ucode-intel flatpak flatpak-remote-flathub gamemode gamemoded libgamemode0 libgamemode0-32bit libgamemodeauto0 libgamemodeauto0-32bit mangohud mangohud-32bit steam gamescope dxvk dxvk-32bit s-tui thermald thermal-monitor kdeconnect-kde fwupd nextcloud-desktop retroarch pcsx2 rpcs3 bibletime yast2-printer skanlite krename ffmpeg-4 realtimeconfigquickscan filelight goldendict
systemctl enable gamemoded@$ME
systemctl enable thermald
gpasswd -a $ME -g power

flatpak install org.remmina.Remmina com.github.vladimiry.ElectronMail com.microsoft.Edge com.google.Chrome com.discordapp.Discord  com.heroicgameslauncher.hgl org.kartkrew.RingRacers org.gimp.GIMP org.telegram.desktop org.onlyoffice.desktopeditors org.qownnotes.QOwnNotes

# La Musica
zypper addrepo -p98 -f https://download.opensuse.org/repositories/multimedia:/proaudio/openSUSE_Tumbleweed  "Geekos Daw"

zypper al yabridget
zypper dup --allow-vendor-change
zypper in --recommends yabridgectl yabridge yabridge-32bit wine-staging wine-staging-32bit wine-staging-devel wine-mono wine-gecko Fire helm-synth lv2-ChowKick lv2-ChowMatrix lv2-distrho-vitalium lv2-dragonfly-reverb lv2-Fire lv2-helm-synth lv2-juicysfplugin lv2-odin2  yoshimi-lv2 yoshimi-banks
