#!/bin/bash
# Script to push the DHCP config

# Script
if [ $# -ge 1 ]; then
	BUILDNAME=$1
fi
# Setup the tftp data
sudo rsync -av $HOSTFILES/etc/dhcp/dhcpd.conf /etc/dhcp/dhcpd.conf
# REstart the service
sudo systemctl restart isc-dhcp-server
