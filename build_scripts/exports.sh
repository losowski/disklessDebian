#!/usr/bin/bash
export BUILDROOTIMAGE=$PWD/../image
# Get version
export  BUILDVERSION=$(cat /etc/os-release | grep "VERSION_CODENAME" | cut -d '=' -f 2)
