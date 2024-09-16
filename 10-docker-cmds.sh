# Start docker in the same CLI
sudo docker run --rm -it -v $PWD/dist:/dist ptrsr/pi-ci start

# Start docker on SSH 22
sudo docker run --rm -p 22:22 ptrsr/pi-ci start
