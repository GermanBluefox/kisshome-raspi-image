# Start docker in the same CLI
sudo docker run --rm -it -v /dist:/dist ptrsr/pi-ci start

# Start docker on SSH 22
sudo docker run --rm -p 22:22 -v /dist:/dist ptrsr/pi-ci start

# Create an image
sudo qemu-img convert -f qcow2 -O raw /dist/distro.qcow2 /dist/image.img
sudo gzip -v -k /dist/image.img
sudo scp /dist/image.img.gz root@iobroker.pro:~/