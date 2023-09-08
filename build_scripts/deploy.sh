#!/bin/bash
# Script to setup the build box

# Import shell
source exports.sh

# Correct the ip forwarding
sudo sed 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf
sysctl -w net.ipv4.ip_forward=1

# Setup the *.ipxe build file
# TODO: Build the ipxe build script

# Sync the build
# Rsync the images/boot to /home/tftp/basic/
sudo rsync -av $BUILDROOTIMAGE/boot/ /home/tftp/basic/

# Rsync the image to /home/nfs/basic/root
chown -R 0 $BUILDROOTIMAGE
sudo rsync --delete-after -av $BUILDROOTIMAGE/ /home/nfs/basic/root/
