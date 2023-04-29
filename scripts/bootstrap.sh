#!/usr/bin/bash
# https://wiki.debian.org/Debootstrap

# Import shell
source exports.sh

# Get version
BUILDVERSION=$(cat /etc/os-release | grep "VERSION_CODENAME" | cut -d '=' -f 2)

# Bootstrap
debootstrap $BUILDVERSION $BUILDROOTIMAGE http://deb.debian.org/debian/

# Setup the directories
echo "proc $BUILDROOTIMAGE/proc proc defaults 0 0" >> /etc/fstab
mount proc $BUILDROOTIMAGE/proc -t proc
echo "sysfs $BUILDROOTIMAGE/sys sysfs defaults 0 0" >> /etc/fstab
mount sysfs $BUILDROOTIMAGE/sys -t sysfs
cp /etc/hosts $BUILDROOTIMAGE/etc/hosts
cp /proc/mounts $BUILDROOTIMAGE/etc/mtab
chroot $BUILDROOTIMAGE /bin/bash
dselect