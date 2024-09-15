#!/bin/bash
# Setup TFTP server
# Create the TFTP directory
sudo mkdir /VMs/tftp
# useradd -d /home/tftp tftp # Already exists
sudo usermod -d /VMs/tftp tftp
# Apply the config
sudo cp ../host/etc/default/tftpd-hpa /etc/default/tftpd-hpa
# Enable and restart
sudo systemctl enable tftpd-hpa
sudo systemctl restart tftpd-hpa
