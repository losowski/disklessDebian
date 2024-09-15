#!/bin/bash
# Script to push the complete image

# Script
if [$# -ge 1]; then
	BUILDNAME=$1
fi
# Copy the contents to the build folder
sudo rsync -av --mkpath $BUILDROOTIMAGE/ /VMs/nfs/$BUILDNAME/