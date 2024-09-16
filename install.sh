#!/bin/bash -e
sudo apt-get update
sudo apt-get upgrade -y
sudo systemctl enable ssh
sudo systemctl start ssh

# create iobroker user
sudo useradd -m -G root iob
echo "iob:2024=smart!" | sudo chpasswd
# set root password
echo "root:2024=smartroot!" | sudo chpasswd
sudo sed -i 's/^#\?\s*PermitRootLogin\s.*/PermitRootLogin no/' "/etc/ssh/sshd_config"
sudo systemctl restart sshd

echo =============================================================
echo Setup timezone
echo =============================================================
sudo timedatectl set-timezone Europe/Berlin
sudo dpkg-reconfigure --frontend noninteractive tzdata

echo =============================================================
echo Install iobroker
echo =============================================================
sudo apt-get -y install net-tools curl wget openssh-server software-properties-common build-essential ca-certificates nano
curl -sLf https://iobroker.net/install.sh | bash -
cd /opt/iobroker
sudo iob stop
# Settings for kisshome
sudo npm install iobroker.admin@latest --unsafe-perm
sudo npm install iobroker.kisshome-research
sudo iob fix
sudo iob add kisshome-research
sudo iob u admin
# End of settings for kisshome
sudo iob unsetup -y

rm -rf /opt/kisshome-raspi-image/
# now you can stop the raspberrypi and create an image
