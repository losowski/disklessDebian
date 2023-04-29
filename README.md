README

# OBJECTIVE:
* Use a debian base image
* Script to build two images
	** Read/Write image
	** Read/Only (unionised) image
* Mount and run an image with minimal overhead
	- Common "root" drive
	- Common "/home" drive
	- RAMDisk for all the local storage
	- tmpfs for /tmp
	- Only configuration needed is the dhcpd configuration to setup a new (identical) host

# REQUIREMENTS:
* A buildbox:
	** Debian installation this will be based off
* Service running:
	** NTP
	** TFTPD
	** DHCPD
	** DNS
	** NFS
	** iSCSID

# GENERAL PROCESS
## Hardware Setup
1) Setup hardware for backend services
	- 1 GB RAM
	- 8 GB Disk
2) Setup hardware for buildbox (can be same as above)
	- +16 GB Disk

## OS Setup
1) Install backend services
2) Install Buildbox Debian
3) Install build applications

## Backend Service Setup and configuration
1) Setup DHCPD service
	- Assign Hostnames and IP to ALL services
	- Also will include config for the bootable image
2) TFTPD Service
	- Service of bootable images
2) Setup DNS Service
3) Setup NFS Service
	- Common "root" drive (for a specific suite of hosts)
	- /home drive
	

## Cloning the buildbox directory structure to NFS
1) Mount the NFS Service
2) Clone linux directory structure from the buildbox to the NFS Drive
3) Clear down to the essential files

## Building Bootable Image

## Publish the image for booting
1) Push to the TFTPD box
2) Update the DHCPD config to point to this bootable image

## Run the bootable image
1) Setup the bootloader

## Bootable Image /home drive setup

## Install Bootable image applications
Barebones Applications:
	- NTP
	- Watchdog
	- ntables
System Applications
	- Kubenetes
	- Ansible
Text User Applications
	- Vim
UI Applications
	- xfce
Specific Task Applications
	- freecad

## Specific Application tweaks (e.g to use /home)

## ReadOnly Configurations
- Mounting to use UnionFS
- Readonly mount of NFS drive
-
