#!/bin/bash -e
sudo apt-get update
sudo apt-get upgrade -y
sudo systemctl enable ssh
sudo systemctl start ssh
sudo apt-get install -y ntpdate

sudo useradd -m -G root iob
# create iobroker user
echo "iob:2024=smart!" | sudo chpasswd
# set root password
echo "root:2024=smartroot!" | sudo chpasswd
sudo sed -i 's/^#\?\s*PermitRootLogin\s.*/PermitRootLogin no/' "/etc/ssh/sshd_config"
sudo systemctl restart sshd

# Copy rc.local to iob user
sudo cp /opt/kisshome-raspi-image/vm/files/rc.local /etc/rc.local
sudo chown iob:root /etc/rc.local
sudo chmod 775 /etc/rc.local
sudo systemctl enable rc-local

sudo cp /opt/kisshome-raspi-image/vm/files/firstboot.sh /home/iob/firstboot.sh
sudo chown iob:root /home/iob/firstboot.sh
sudo chmod 775 /home/iob/firstboot.sh


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
sudo npm install iobroker.kisshome-research
iob fix
iob add kisshome-research
systemctl stop iob
iob unsetup -y
# now you can stop the docker and create an image
