#!/bin/bash
# Script to push the home directory to setup users where

# Copy chroot scripts to the image /root folder
sudo rsync -av ./chroot/ $BUILDROOTIMAGE/root

# Run Scripts
sudo chroot $BUILDROOTIMAGE /root/setup_users.sh

# Synchronise home directory
sudo rsync -av $BUILDROOTIMAGE/home/ /VMs/nfs/home/
