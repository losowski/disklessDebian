#!/bin/bash
# Setup NFS
## URL: https://wiki.debian.org/Bind9
#	TODO: Setup the bind9 config
#	TODO: Setup the rndc service to be the default DNS for this subnet
sudo systemctl enable bind9
sudo systemctl restart bind9