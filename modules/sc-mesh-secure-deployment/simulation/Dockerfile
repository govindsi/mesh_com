FROM ubuntu:14.04

# LABEL about the custom image
LABEL maintainer="SecComms SSRC"

LABEL version="0.1"

LABEL description="Batman Mesh Simulation."

# Disable Prompt During Packages Installation
#ARG DEBIAN_FRONTEND=noninteractive

#RUN bash

WORKDIR /home

CMD sudo apt install git python-pygtk python-gobject python-cairo python-ipdb math pickle os netsnmp time and vboxapi  -y

CMD sudo apt-get install linux-headers-generic virtualbox-dkms

CMD sudo apt install virtualbox

CMD git clone https://github.com/dbritos/Network-mesh-emulator.git

CMD cd Network-mesh-emulator; sudo ./install.sh

CMD vboxmanage hostonlyif create; vboxmanage hostonlyif ipconfig vboxnet0 --ip 192.168.56.1

CMD bash




