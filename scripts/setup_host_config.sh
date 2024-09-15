#!/bin/bash
# Script to copy the configuration over to the host system
# Assume there is no-prexisting configuration to overwrite- and replace with scricter configuration
# use configuration files from "host" directory (should be in same directory tree)
# Perform service restarts too


# == nftables setup ==
#	Set Subnet mask for the allowed networks (should only be internal)
#	Copy the config over to the host (host/etc/nftables.conf)
sudo cp ../host/etc/nftables.conf /etc/nftables.conf
sudo /sbin/nft -f /etc/nftables.conf


# == Port-forwarding
# Correct the ip forwarding
sudo sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf
sudo sysctl -w net.ipv4.ip_forward=1


# == DHCPD server ==
#  Set the interface to use for the DHCP server via host/etc/default/isc-dhcp-server
# Chose the subnet setup 192.168.124.x/24
#	host/etc/dhcp/dhcpd.conf
#	Setup group naming
#	Setup default netboot offering
#	Set config on the host server
sudo cp ../host/etc/default/isc-dhcp-server /etc/default/isc-dhcp-server
sudo cp ../host/etc/dhcp/dhcpd.conf  /etc/dhcp/dhcpd.conf
# Set the subnet on the interface
## Superceded since virtualbox sets up the interface properly
#sudo cp ../host/etc/network/interfaces.d/virbr1 /etc/network/interfaces.d/virbr1
#sudo systemctl restart networking
# Enable and restart
sudo systemctl enable isc-dhcp-server
sudo systemctl restart isc-dhcp-server


# == DNS Server ==
$PWD/setup_bind9.sh

# == TFTP ==
$PWD/setup_tftp.sh

# == NFS Server ==
$PWD/setup_nfs.sh

# == Build IPXE ==
$PWD/build_ipxe.sh

# == Copy IPXE to tftp directory ==
# == Copy Linux Kernel to tftp directory ==
# == Copy Linux Kernel to nfs directory ==
$PWD/push_boot.sh

# == Copy Boot Image to nfs diretory ==
$PWD/push_image.sh

# BOOM! Read to boot
