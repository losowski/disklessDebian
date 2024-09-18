#!/bin/bash
# Setup NFS
# TODO: Create a bootable environment
# Create the home directory under "/VMs/nfs"
sudo mkdir -p /VMs/nfs
sudo useradd -d /VMs/nfs nfs
# Create sub-directories
sudo mkdir -p /VMs/nfs/home
chown nfs /VMs/nfs/home
# Apply the config
sudo cp -v $HOSTFILES/etc/exports /etc/exports
sudo cp -v $HOSTFILES/etc/default/nfs-common /etc/default/nfs-common
# Enable and restart
sudo systemctl enable nfs-server
sudo systemctl restart nfs-server