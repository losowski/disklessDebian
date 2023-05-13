#!/usr/bin/bash
# https://wiki.debian.org/Debootstrap

# Import shell
source exports.sh

# Get version
BUILDVERSION=$(cat /etc/os-release | grep "VERSION_CODENAME" | cut -d '=' -f 2)

# Bootstrap
debootstrap $BUILDVERSION $BUILDROOTIMAGE http://deb.debian.org/debian/

# See: image/etc/sources.list

# Configure hostnames
chroot $BUILDROOTIMAGE /bin/bash
apt update
apt -y install bind9-host locales
locale-gen en_US.UTF-8
dpkg-reconfigure locales
exit #exit chroot

# See: image/bin/whereami
# See: image/etc/rc.local

# Install NFS
chroot $BUILDROOTIMAGE /bin/bash
apt -y install nfs-common
exit #exit chmod

# Setup: image/etc/fstab
cp templates/fstab $BUILDROOTIMAGE/etc/fstab
# NOTE: Append nfsserver line
# TODO: Add build script to correctly setup the nfsserver line for build
# sed -i "s/nfsserver:NFSHOMEPATH/nfsserver:BLAH/g' $BUILDROOTIMAGE/etc/fstab


# Setup: image/etc/mtab
# A symlink as this is replaced in the initrd
ln -s /proc/mounts $BUILDROOTIMAGE/etc/mtab


# Configure root user
chroot $BUILDROOTIMAGE /bin/bash
passwd root
mv /root /home/root
usermod -d /home/root root

exit #exit chroot

# Build a PXE initrd
chroot $BUILDROOTIMAGE /bin/bash
# apt update
# apt -y install linux-image-amd64 firmware-linux \
firmware-realtek firmware-bnx2
# exit

# exit the 


# Setup the directories
#echo "proc $BUILDROOTIMAGE/proc proc defaults 0 0" >> /etc/fstab
#mount proc $BUILDROOTIMAGE/proc -t proc
#echo "sysfs $BUILDROOTIMAGE/sys sysfs defaults 0 0" >> /etc/fstab
#mount sysfs $BUILDROOTIMAGE/sys -t sysfs
#cp /etc/hosts $BUILDROOTIMAGE/etc/hosts
#cat /proc/mounts | sed 's/^\/dev.*//g' | sed 's/\n\n//g' > $BUILDROOTIMAGE/etc/mtab

# dselect

