#!/usr/bin/bash
# https://wiki.debian.org/Debootstrap
# Requires running as sudo

# Import shell
source exports.sh

# Get version
BUILDVERSION=$(cat /etc/os-release | grep "VERSION_CODENAME" | cut -d '=' -f 2)

# Bootstrap
sudo debootstrap $BUILDVERSION $BUILDROOTIMAGE http://deb.debian.org/debian/
# $BUILDROOTIMAGE/debootstrap/debootstrap.log
# Check logs at

# See: image/etc/apt/sources.list
# NOTE: /etc/apt/sources.list gets overwritten by above
sudo cp $BUILDROOTIMAGE/../templates/sources.list $BUILDROOTIMAGE/etc/apt/sources.list

sudo chroot $BUILDROOTIMAGE /bin/bash
apt update
# Configure hostnames
apt -y install bind9-host locales
locale-gen en_US.UTF-8
 # Has interactive menu
dpkg-reconfigure locales
# Install NFS
apt -y install nfs-common
exit #exit chroot

# See: image/bin/whereami
# See: image/etc/rc.local

# Setup: image/etc/fstab
sudo cp $BUILDROOTIMAGE/../templates/fstab $BUILDROOTIMAGE/etc/fstab
# NOTE: Append nfsserver line
# TODO: Add build script to correctly setup the nfsserver line for build
# sudo sed -i "s/nfsserver:NFSHOMEPATH/nfsserver:BLAH/g' $BUILDROOTIMAGE/etc/fstab

# Setup: image/etc/mtab
# A symlink as this is replaced in the initrd
sudo ln -s /proc/mounts $BUILDROOTIMAGE/etc/mtab

# Configure root user
sudo chroot $BUILDROOTIMAGE /bin/bash
passwd root
usermod -d /root root
exit #exit chroot

# Build a PXE initrd
sudo chroot $BUILDROOTIMAGE /bin/bash
apt update
#apt -y install linux-image-amd64 firmware-linux-free # Default
apt -y install linux-image-cloud-amd64 # For Virtual machines only
exit #exit chroot

# Copy initramfs.conf
sudo cp $BUILDROOTIMAGE/../templates/initramfs.conf $BUILDROOTIMAGE/etc/initramfs-tools/initramfs.conf

# Actually build the initramfs
sudo chroot $BUILDROOTIMAGE /bin/bash
update-initramfs -u
exit #exit chroot

#NOTE: Built files:
ls $BUILDROOTIMAGE/bin/initrd.img*
ls $BUILDROOTIMAGE/bin/vmlinuz*

# Setup RAMDisk for temporary files
sudo chroot $BUILDROOTIMAGE /bin/bash
echo ASYNCMOUNTNFS=no >> /etc/default/rcS
echo RAMTMP=yes >> /etc/default/tmpfs
exit


# TODO: Add tar step to compress this build
