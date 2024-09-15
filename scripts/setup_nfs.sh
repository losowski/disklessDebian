#!/bin/bash
# Setup NFS
# TODO: Create a bootable environment
# Create the home directory under "/VMs/nfs"
sudo mkdir -p /VMs/nfs
sudo useradd -d /VMs/nfs nfs
# Create sub-directories
sudo su - nfs
sudo mkdir -p /VMs/nfs/home
# Apply the config
sudo cp ../host/etc/default/nfs-common /etc/default/nfs-common
# Enable and restart
sudo systemctl enable nfs-server
sudo systemctl restart nfs-server