#!/usr/bin/bash
# Script to install the required applications on the build box
# Assume Debian base
# Setup the Buildbox source list
sudo cp sources.list /etc/apt/sources.list

# Update
sudo apt update

# Upgrade
sudo apt -y upgrade

# Install the build software
sudo apt -y install debootstrap