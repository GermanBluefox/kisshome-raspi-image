# kisshome-raspi-image
Creates Raspberry Pi Image

Merged from 2 github repos:
- Buanet https://github.com/buanet/ioBroker.raspberry-os/tree/6220fdfee4a86b1eb31d6fee50a5b0f27cda6a00/stage-iobroker
- https://github.com/ptrsr/pi-ci


## How to start
```
sudo apt-get update
sudo apt install git
cd /opt
sudo git clone https://github.com/GermanBluefox/kisshome-raspi-image
cd kisshome-raspi-image/vm
sudo chmod +x *.sh
cd ./files
sudo chmod +x *.sh
cd ..
sudo ./start.sh
```
