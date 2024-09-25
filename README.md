# kisshome-raspi-image
Creates Raspberry Pi Image with preinstalled kisshome-research adapter

## How to start
```
echo sudo apt update
sudo apt install -y git
cd /opt
sudo git clone https://github.com/GermanBluefox/kisshome-raspi-image
sudo chmod +x /opt/kisshome-raspi-image/install.sh
sudo /opt/kisshome-raspi-image/install.sh
```

## After creation
The ssh login is `iob` and the password is `iob:2024=smart!`. Change the password immediately after the first reboot!

The root password is `2024=smartroot!`.
