#!/usr/bin/bash
# Setup Locales

# Import shell
source exports.sh

# Setup locales
chroot $BUILDROOTIMAGE

# Update apt
apt update

# Install required programmes for the bootable image
apt -y install bind9-host locales


dpkg-reconfigure locales