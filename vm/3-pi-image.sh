#!/bin/bash -e
sudo apt-get install qemu-utils
sudo docker pull ptrsr/pi-ci

sudo mkdir /dist
sudo cp ./files/* /dist

# Resize image to 4GB
sudo docker run --rm -it -v /dist:/dist ptrsr/pi-ci resize 4G

sudo docker run --rm -it -v /dist:/dist ptrsr/pi-ci sudo /usr/bin/bash /dist/install.sh

