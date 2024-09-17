#!/bin/bash
# https://wiki.debian.org/Debootstrap
# Requires running as sudo

# Check we are configured else exit
echo $BUILDVERSION
if [ $(echo $BUILDVERSION) ]; then
	echo "BUILDVERSION OK"
else
	echo "BUILDVERSION is not set"
	exit
fi
echo $BUILDROOTIMAGE
if [ $(echo $BUILDROOTIMAGE) ]; then
	echo "BUILDROOTIMAGE OK"
else
	echo "BUILDROOTIMAGE is not set"
	exit
fi


# Store the archive
if [ -f ../cache/debian_"$BUILDVERSION"_image.tar ]; then
	echo "Cached build exists"
	exit
else
	sudo tar -cvf $(echo "../cache/debian_"$BUILDVERSION"_image.tar") $BUILDROOTIMAGE
fi

# TODO: Change the image/home path to the /VMs/nfs/home path

# Bootstrap
sudo debootstrap --no-merged-usr $BUILDVERSION $BUILDROOTIMAGE http://deb.debian.org/debian/
# Check logs at $BUILDROOTIMAGE/debootstrap/debootstrap.log

# Clear the /etc/hostname
# Required for correctly setting details via DHCP
echo "" > $BUILDROOTIMAGE/etc/hostname

# Add a dummy file to the image to indicate origin
echo "NFS Drive ROOT" | tee $BUILDROOTIMAGE/nfs_type
echo "NFS basic $BUILDVERSION" | tee $BUILDROOTIMAGE/etc/nfs_version

# See: image/etc/apt/sources.list
# NOTE: /etc/apt/sources.list gets overwritten by above
sudo cp $BUILDTEMPLATE/etc/apt/sources.list $BUILDROOTIMAGE/etc/apt/sources.list

# Setup: image/etc/fstab
sudo cp $BUILDTEMPLATE/etc/fstab $BUILDROOTIMAGE/etc/fstab
# NOTE: Append nfsserver line
# TODO: Add build script to correctly setup the nfsserver line for build
# sudo sed -i "s/nfsserver:NFSHOMEPATH/nfsserver:BLAH/g' $BUILDROOTIMAGE/etc/fstab

# Copy initramfs.conf
sudo cp $BUILDTEMPLATE/etc/initramfs-tools/initramfs.conf $BUILDROOTIMAGE/etc/initramfs-tools/initramfs.conf


# Copy chroot scripts to the image /root folder
sudo rsync -av ./chroot/ $BUILDROOTIMAGE/root

# Run Scripts
sudo chroot $BUILDROOTIMAGE /root/setup_image.sh

#NOTE: Built files:
ls $BUILDROOTIMAGE/boot/initrd.img*
ls $BUILDROOTIMAGE/boot/vmlinuz*

# TODO: Add tar step to compress this build
if [ -f ../cache/debian_"$BUILDVERSION"_image.tar ]; then
	echo "Cached build exists"
else
	sudo tar -cvf $(echo "../cache/debian_"$BUILDVERSION"_image.tar") $BUILDROOTIMAGE
fi

