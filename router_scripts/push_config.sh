#!/bin/bash
# Script to copy the configuration over to the host system
# Assume there is no-prexisting configuration to overwrite- and replace with scricter configuration


# == nftables setup ==
#	TODO: Set Subnet mask for the allowed networks (should only be internal)
#	TODO: Copy the config over to the host (host/etc/nftables.conf)

# == DHCPD server ==
# TODO: Set the interface to use for the DHCP server via host/etc/default/isc-dhcp-server
# Chose the subnet setup 192.168.124.x/24
#	TODO: host/etc/dhcp/dhcpd.conf
#	TODO: Setup group naming
#	TODO: Setup default netboot offering
#	TODO: Set config on the host server
# Enable and restart
systemctl enable isc-dhcp-server
systemctl restart isc-dhcp-server

# == DNS Server ==
#	TODO: Setup the bind9 config
#	TODO: Setup the rndc service to be the default DNS for this subnet
systemctl enable bind9
systemctl restart bind9

# == Change Ip4 Routing to enable service as router
