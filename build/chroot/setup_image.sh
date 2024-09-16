#!/usr/bin/bash
# Script to build the chroot files

apt update
# Configure hostnames
apt -y install bind9-host locales
locale-gen en_US.UTF-8
 # Has interactive menu
dpkg-reconfigure locales
# Install NFS
apt -y install nfs-common

# Setup: image/etc/mtab
# A symlink as this is replaced in the initrd
sudo ln -s /proc/mounts /etc/mtab

# Configure root user
# Note: same process needs application for all users
#		Especially true if running the root OS as UnionFS
passwd root
usermod -d /root root


# Setup RAMDisk for temporary files
echo ASYNCMOUNTNFS=no >> /etc/default/rcS
echo RAMTMP=yes >> /etc/default/tmpfs


# Build a PXE initrd
#apt -y install linux-image-amd64 firmware-linux-free # Default
apt -y install linux-image-cloud-amd64 # For Virtual machines only
apt -y install systemd init xz-utils


# Actually build the initramfs
update-initramfs -vu

#NOTE: Built files:
ls /boot/initrd.img*
ls /boot/vmlinuz*




