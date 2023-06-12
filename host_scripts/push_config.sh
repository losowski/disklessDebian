#!/bin/bash
# Script to copy the configuration over to the host system
# Assume there is no-prexisting configuration to overwrite- and replace with scricter configuration
# TODO: Implement this via rsync
# TODO: use configuration files from "host" directory (should be in same directory tree)
# TODO: Perform service restarts too


# == nftables setup ==
#	TODO: Set Subnet mask for the allowed networks (should only be internal)
#	TODO: Copy the config over to the host (host/etc/nftables.conf)
sudo cp etc/nftables.conf /etc/nftables.conf
sudo /sbin/nft -f /etc/nftables.conf

# == DHCPD server ==
# TODO: Set the interface to use for the DHCP server via host/etc/default/isc-dhcp-server
# Chose the subnet setup 192.168.124.x/24
#	TODO: host/etc/dhcp/dhcpd.conf
#	TODO: Setup group naming
#	TODO: Setup default netboot offering
#	TODO: Set config on the host server
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
# TODO: Create the home directories
# TODO: Create a home directory "/home/tftp"
sudo mkdir /home/tftp
# useradd -d /home/tftp tftp # Already exists
sudo usermod -d /home/tftp tftp

# TODO: Apply the config
# Enable and restart
sudo systemctl enable tftpd-hpa
sudo systemctl restart tftpd-hpa

# == NFS Server ==
# TODO: Create a bootable environment
# TODO: Create the home directory under "/home/nfs"
sudo useradd -d /home/nfs nfs
sudo su - nfs
mkdir -p /home/nfs/home
mkdir -p /home/nfs/simple-client/root
# Enable and restart
sudo systemctl enable nfs-server
sudo systemctl restart nfs-server
