#!/bin/bash -e
sudo apt-get install qemu-utils
sudo docker pull ptrsr/pi-ci

sudo mkdir -p /dist
sudo cp ./files/* /dist

# Resize image to 4GB
sudo docker run --rm -it -v /dist:/dist ptrsr/pi-ci resize -y 4G

echo Run command in emulator:
echo sudo apt update && sudo apt install -y git && cd /opt && sudo git clone https://github.com/GermanBluefox/kisshome-raspi-image && sudo chmod +x /opt/kisshome-raspi-image/vm/files/install.sh && sudo /opt/kisshome-raspi-image/vm/files/install.sh
sudo docker run --rm -p 22:22 -v /dist:/dist ptrsr/pi-ci start
# sudo docker run --rm -it -v /dist:/dist ptrsr/pi-ci /usr/bin/bash /dist/install.sh

