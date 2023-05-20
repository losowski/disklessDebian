#!/bin/bash
# Installation script for required packages
# nftables Setup (none)
# DHCPD server
sudo apt -y install isc-dhcp-server
# DNS Server
sudo apt -y install bind9 bind9-utils
# TFTP server
sudo apt -y install tftpd-hpa tftp
# NFS Server
sudo apt -y install nfs-kernel-server
