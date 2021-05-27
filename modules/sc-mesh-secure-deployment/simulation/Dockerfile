FROM ubuntu:16.04

# LABEL about the custom image
LABEL maintainer="SecComms SSRC"

LABEL version="0.1"

LABEL description="Batman Mesh Simulation."

# Disable Prompt During Packages Installation
#ARG DEBIAN_FRONTEND=noninteractive

#RUN bash

WORKDIR /home

ADD . /home

RUN apt update && apt install git python-gobject python-cairo wget nano  -y
#

#
RUN apt-get install build-essential dkms linux-headers-generic virtualbox-dkms  -y



RUN apt-get -y remove libvdeplug2
RUN apt-get -y install libvdeplug2  snmp python-gtk2-dev python-netsnmp python-ipdb


RUN git clone https://github.com/dbritos/Network-mesh-emulator.git

RUN cd Network-mesh-emulator &&  tar -xf vde2-2.3.2-patch.tar ; cd vde2-2.3.2-patch; ./configure ; make ; make install

RUN vboxmanage import Network-mesh-emulator/openwrtv12.ova

#RUN vboxmanage hostonlyif create; vboxmanage hostonlyif ipconfig vboxnet0 --ip 192.168.56.1


#




