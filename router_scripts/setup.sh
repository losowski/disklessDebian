#!/bin/bash
# Script to setup the router box (this is the host if using VM)

# Correct the ip forwarding
sudo sed 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf
sysctl -w net.ipv4.ip_forward=1