#!/bin/bash
# Script to copy the configuration over to the host system
# Assume there is no-prexisting configuration to overwrite- and replace with scricter configuration
# TODO: Implement this via rsync
# TODO: use configuration files from "host" directory (should be in same directory tree)
# TODO: Perform service restarts too
# nftables Setup
# Chose the subnet setup
# Copy the config over to the host

# DHCPD server
# DNS Server

# TFTP
# Create the home directories
# Apply the config
# Restart the services
systemctl enable tftpd-hpa
systemctl restart tftpd-hpa

# NFS Server restart
systemctl restart nfs-server
