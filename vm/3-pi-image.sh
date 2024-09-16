#!/bin/bash -e
sudo docker pull ptrsr/pi-ci
# Resize image to 4GB
sudo docker run --rm -it ptrsr/pi-ci resize 4G
sudo docker run --rm -it -v $PWD/dist:/dist ptrsr/pi-ci start