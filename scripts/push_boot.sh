#!/bin/bash
# Script to push the linux kernel

# Script
if [ $# -ge 1 ]; then
	BUILDNAME=$1
fi
# Setup the tftp data
sudo rsync -av --mkpath $BUILDROOTIMAGE/boot/ /VMs/tftp/$BUILDNAME/
# Copy the contents to the build folder
sudo rsync -av --mkpath $BUILDROOTIMAGE/boot/ /VMs/nfs/$BUILDNAME/boot/
