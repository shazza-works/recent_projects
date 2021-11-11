#!/usr/bin/bash
#
# Shazza_Works 11/NOV/2021
# Easy Ubuntu setup after a reset or reinstall
# (To add):
# 1. return code checking on most of the ops
# 2. SEC installs and setup ufw fail etc
# 3. colour or images to prompts
#

clear
touch ~/LOGFILE.log
echo -e "\n\n[🔧] Will Now Setup Ubuntu as best as I can to working state...\n\n"
echo -e "\n\n[ℹ] Logging will be done in LOGFILE.log"
sleep 5

# add shell alias to .bashrc
echo -e "[ℹ] Adding Shazza Alias to .bashrc."
echo -e "# Shazza Alias's #\n" >> ~/.bashrc
echo -e "alias cl='clear'" >> ~/.bashrc
echo -e "alias python='python3'" >> ~/.bashrc

# Updates
echo -e "[🔧] Updating APT repository now."
sudo apt update >> ~/LOGFILE.log
sudo apt upgrade --yes >>  ~/LOGFILE.log
echo -e "[ℹ] Update + Upgrade now done."


# Snaps ( I HATE THEM ! )
echo -e "[🔧] Installing Snaps now."
snap install electron-mail shortwave | tee -a ~/LOGFILE.log

echo -e "[🔧] Updating mlocate database."
sudo updatedb
echo -e "[ℹ] Mlocate file indexing finished."


# Install apt programs
echo -e "[🔧] Starting APT install's now."
sudo apt -f install python3 python3-pip idle wget curl nmap net-tools dnsutils tree gpart warzone2100 youtube-dl k3b vlc libgtkglext1 qbittorrent git indicator-sensors nano mlocate virtualbox virtualbox-guest-additions-iso libgconf-2-4 libc++1 libappindicator1  --yes >>  ~/LOGFILE.log
echo -e "[ℹ] APT install's are now done."


# Pip's
echo -e "[🔧] Starting pip installs."
pip install pandas discord requests aes HN python-magic python-whois discord-webhook regex >> ~/LOGFILE.log
echo -e "[ℹ] Python Pip's are now finished."

# Check apt agin
sudo apt -f install --yes >> ~/LOGFILE.log

# Discord
echo -e "[🔧] Discord download and setup client and deps."
wget "https://discord.com/api/download?platform=linux&format=deb" -O discord.deb | tee -a ~/LOGFILE.log
sudo apt install 
sudo dpkg -i discord.deb >> ~/LOGFILE.log
if [[ $? == 0 ]]; then
	rm -rf discord.deb
	echo -e "[ℹ] Discord client is now installed."
else
	echo -e "[⚠] WARNING DISCORD INSTALL FUCKED UP BROV !"
fi

# Xonotic
echo -e "[🔧] Setting up and downloading Xonotic game Server folder and Client Snap."
sudo snap xonotic | tee -a ~/LOGFILE.log
# get server files
wget "https://dl.xonotic.org/xonotic-0.8.2.zip" -O Xonotic.zip | tee -a ~/LOGFILE.log
unzip Xonotic.zip | tee -a ~/LOGFILE.log
rm -rf Xonotic.zip
# do the mkdir -p data here and add the config file.
echo -e "[ℹ] Xonotic game and files installed."

# Edit your .bash_rc file
echo -e "[ℹ] You can now add more alias's to your shell config.\n\n"
echo -e "[ℹ] Please Wait and it will open... (Ctl+s) to save.\n[*] Then just close the editor.\n"
gnome-text-editor ~/.bashrc
echo -e "[ℹ] BASH config edit done."

# Terminal Profile
echo -e "[🔧] Setting the Terminal Profile To Shazza\n"
key=$(gsettings get org.gnome.Terminal.ProfilesList list | cut -f 2 -d "'")
dconf load /org/gnome/terminal/legacy/profiles:/:$key/ < ~/term.cfg
echo -e "[ℹ] Setting the terminal profile Done."

# SSH Key Setup
echo -e "[🔧] Setting up some SSH keys for you\n\n"
ssh-keygen -t rsa -b 4096 -C "${USER} SSH key" -f ~/.ssh/id_rsa -N "$(read -p 'Enter your new SSH key password to encrypt if you like?')" | tee -a ~/LOGFILE.log
echo -e "[ℹ] Setting up SSH keys is done, key app on the dock shortcuts."

# Shortcuts
echo -e "[🔧] Setting the dock to the bottom as it should be !"
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'BOTTOM'
echo -e "[🔧] Setting the dock to autohide mode."
gsettings set org.gnome.shell.extensions.dash-to-dock autohide true
echo -e "[🔧] Setting the Desktop Image to better pic"
gsettings set org.gnome.desktop.background picture-uri "https://wallpaperaccess.com/full/5856068.jpg"

echo -e "[🔧] Setting up desktop shortcuts for installed apps"
gsettings set org.gnome.shell favorite-apps "$(gsettings get org.gnome.shell favorite-apps | sed s/.$//), 'org.gnome.DiskUtility.desktop']"
gsettings set org.gnome.shell favorite-apps "$(gsettings get org.gnome.shell favorite-apps | sed s/.$//), 'xonotic_xonotic.desktop']"
gsettings set org.gnome.shell favorite-apps "$(gsettings get org.gnome.shell favorite-apps | sed s/.$//), 'shortwave_shortwave.desktop']"
gsettings set org.gnome.shell favorite-apps "$(gsettings get org.gnome.shell favorite-apps | sed s/.$//), 'discord.desktop']"
gsettings set org.gnome.shell favorite-apps "$(gsettings get org.gnome.shell favorite-apps | sed s/.$//), 'warzone2100.desktop']"
gsettings set org.gnome.shell favorite-apps "$(gsettings get org.gnome.shell favorite-apps | sed s/.$//), 'org.gnome.Terminal.desktop']"
gsettings set org.gnome.shell favorite-apps "$(gsettings get org.gnome.shell favorite-apps | sed s/.$//), 'org.gnome.Screenshot.desktop']"
gsettings set org.gnome.shell favorite-apps "$(gsettings get org.gnome.shell favorite-apps | sed s/.$//), 'gnome-control-center.desktop']"
gsettings set org.gnome.shell favorite-apps "$(gsettings get org.gnome.shell favorite-apps | sed s/.$//), 'update-manager.desktop']"
gsettings set org.gnome.shell favorite-apps "$(gsettings get org.gnome.shell favorite-apps | sed s/.$//), 'idle.desktop']"
gsettings set org.gnome.shell favorite-apps "$(gsettings get org.gnome.shell favorite-apps | sed s/.$//), 'org.qbittorrent.qBittorrent.desktop']"
gsettings set org.gnome.shell favorite-apps "$(gsettings get org.gnome.shell favorite-apps | sed s/.$//), 'indicator-sensors.desktop']"
gsettings set org.gnome.shell favorite-apps "$(gsettings get org.gnome.shell favorite-apps | sed s/.$//), 'electron-mail_electron-mail.desktop']"
gsettings set org.gnome.shell favorite-apps "$(gsettings get org.gnome.shell favorite-apps | sed s/.$//), 'virtualbox.desktop']"
gsettings set org.gnome.shell favorite-apps "$(gsettings get org.gnome.shell favorite-apps | sed s/.$//), 'org.gnome.seahorse.Application.desktop']"
gsettings set org.gnome.shell favorite-apps "$(gsettings get org.gnome.shell favorite-apps | sed s/.$//), 'gnome-system-monitor.desktop']"

echo -e "[ℹ] Setting the desktop shortcuts finished."
echo -e "\n\n\t\t[✅] All Task Are Now Done...\n\n"
echo -e "[ℹ] **Please see your log file @ ~/LOGFILE.log**\n"
echo -e "[ℹ] Now that everything is installed you should restrt..."
read -p "Restart the computer now ?[y/Y]" ans
if [[ $ans == "y" ]] || [[ $ans == "Y" ]]; then
	reboot
else
	exit 0
### EOF###
