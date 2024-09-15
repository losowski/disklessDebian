#!/bin/bash
# Script to reset the network after using sleep
sudo systemctl restart networking
sudo systemctl restart isc-dhcp-server.service
sudo systemctl restart nfs-server