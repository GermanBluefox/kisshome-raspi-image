#!/bin/bash -e
# Add time.google.com to NTP service
sudo sed -i 's/^#NTP=.*/NTP=time.google.com/' /etc/systemd/timesyncd.conf
sudo systemctl restart systemd-timesyncd

sudo apt-get update
sudo apt-get upgrade -y
sudo systemctl enable ssh
sudo systemctl start ssh

# Check if user 'iob' exists, if not create it
if id "iob" &>/dev/null; then
  echo "User 'iob' already exists."
else
  echo "Creating user 'iob'."
  sudo useradd -m -G sudo iob
  echo "iob:2024=smart!" | sudo chpasswd
fi

# Set root password
echo "root:2024=smartroot!" | sudo chpasswd
sudo sed -i 's/^#\?\s*PermitRootLogin\s.*/PermitRootLogin no/' "/etc/ssh/sshd_config"
sudo systemctl restart sshd

# Setup timezone
sudo timedatectl set-timezone Europe/Berlin
sudo dpkg-reconfigure --frontend noninteractive tzdata

# Install iobroker
sudo apt-get -y install net-tools curl wget openssh-server software-properties-common build-essential ca-certificates nano
curl -sLf https://iobroker.net/install.sh | bash -
cd /opt/iobroker
sudo iob stop

# Add to /etc/sudoers.d/iobroker the "iobroker ALL=(ALL) NOPASSWD: /usr/sbin/iwlist"
# Define the line to check/add
LINE="iobroker ALL=(ALL) NOPASSWD: /usr/sbin/iwlist"
FILE="/etc/sudoers.d/iobroker"
# Check if the line is already in the file
if ! grep -Fxq "$LINE" "$FILE"; then
    # If not, add the line to the file
    echo "$LINE" | sudo tee -a "$FILE"
    echo "iwlist added to $FILE"
else
    echo "iwlist already exists in $FILE"
fi
LINE="iobroker ALL=(ALL) NOPASSWD: /usr/bin/nmcli"
FILE="/etc/sudoers.d/iobroker"
# Check if the line is already in the file
if ! grep -Fxq "$LINE" "$FILE"; then
    # If not, add the line to the file
    echo "$LINE" | sudo tee -a "$FILE"
    echo "nmcli added to $FILE"
else
    echo "nmcli already exists in $FILE"
fi

# Settings for kisshome
sudo iob add kisshome-research
sudo iob add welcome
#sudo iob add network-settings
# End of settings for kisshome
sudo iob unsetup -y

# Clean up
sudo rm -rf /opt/kisshome-raspi-image/
sudo rm -rf /etc/NetworkManager/system-connections/*
sudo shutdown -h now
# now you can stop the raspberrypi and create an image
