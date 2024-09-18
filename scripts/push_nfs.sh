#!/bin/bash
# Script to push the NFS Export config

# Setup the tftp data
sudo cp -v $HOSTFILES/etc/exports /etc/exports
# Restart the service
sudo systemctl restart nfs-server

# Testing script
echo "mkdir -p /tmp/nfs"
echo "sudo mount -v -t nfs $BUILDROOT /tmp/nfs"