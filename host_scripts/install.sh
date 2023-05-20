#!/bin/bash
# Installation script for required packages
# nftables Setup
# NONE
# DHCPD server

# DNS Server
# TFTP server
sudo apt -y install tftpd-hpa tftp
# NFS Server
sudo apt -y install nfs-kernel-server
