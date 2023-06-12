#!/bin/bash
# Script to copy the configuration over to the host system
# Assume there is no-prexisting configuration to overwrite- and replace with scricter configuration
# use configuration files from "host" directory (should be in same directory tree)
# Perform service restarts too


# == nftables setup ==
#	Set Subnet mask for the allowed networks (should only be internal)
#	Copy the config over to the host (host/etc/nftables.conf)
sudo cp etc/nftables.conf /etc/nftables.conf
sudo /sbin/nft -f /etc/nftables.conf

# == DHCPD server ==
#  Set the interface to use for the DHCP server via host/etc/default/isc-dhcp-server
# Chose the subnet setup 192.168.124.x/24
#	host/etc/dhcp/dhcpd.conf
#	Setup group naming
#	Setup default netboot offering
#	Set config on the host server
#	TODO: Fix the dhcpd.conf config
sudo cp etc/dhcp/dhcpd.conf  /etc/dhcp/dhcpd.conf
# Enable and restart
sudo systemctl enable isc-dhcp-server
sudo systemctl restart isc-dhcp-server

# == DNS Server ==
#	TODO: Setup the bind9 config
#	TODO: Setup the rndc service to be the default DNS for this subnet
sudo systemctl enable bind9
sudo systemctl restart bind9

# == TFTP ==
# Create the home directories
# Create a home directory "/home/tftp"
sudo mkdir /home/tftp
# useradd -d /home/tftp tftp # Already exists
sudo usermod -d /home/tftp tftp

# Apply the config
sudo cp etc/default/tftpd-hpa /etc/default/tftpd-hpa
# Enable and restart
sudo systemctl enable tftpd-hpa
sudo systemctl restart tftpd-hpa

# == NFS Server ==
# TODO: Create a bootable environment
# Create the home directory under "/home/nfs"
sudo useradd -d /home/nfs nfs
sudo su - nfs
mkdir -p /home/nfs/home
mkdir -p /home/nfs/simple-client/root
# Apply the config
sudo cp etc/default/nfs-common /etc/default/nfs-common
# Enable and restart
sudo systemctl enable nfs-server
sudo systemctl restart nfs-server
