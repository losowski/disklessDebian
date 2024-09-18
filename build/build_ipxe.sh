#!/bin/bash
# Build the IPXE file for NFS

# URL:
#	https://www.kernel.org/doc/Documentation/filesystems/nfs/nfsroot.txt

# Build IPXE
# 1	-	Verion (base
buildIPXE () {
	# IPXE file
	IPXEFILE=$(echo $1".ipxe")
	# IPXE path
	IPXEPATH=$(echo $BUILDROOTIMAGE"/boot/"$IPXEFILE )
	# Describe actions
	if [ -d $IPXEFILE ]; then
		echo $IPXEFILE" exists, overwriting"
	else
		echo "Creating: "$IPXEFILE
	fi
	# Linux Version
	LINUXVER=$(ls -1 $BUILDROOTIMAGE/boot/vmlinuz*| sed 's/^.*\///g' | cut -d '-' -f 2)
	# Get image build from LIVE ../image/boot/
	# IPXE Build paths
	INITRD=$(ls -1 $BUILDROOTIMAGE/boot/initrd* | sed 's/^.*\///g' )
	VMLINUZ=$(ls -1 $BUILDROOTIMAGE/boot/vmlinuz*| sed 's/^.*\///g' )
	NFSPATH="/VMs/nfs/"$1
	VMLINUZPATH=$(echo $VMLINUZ" root=/dev/nfs nfsroot="$BUILDROOT" ro panic=60")
	echo "Output filename: "$IPXEFILE
cat > $(echo $IPXEFILE) << EOF
#!ipxe
$(echo "# IPXE Netboot configuration for build: "$1)
$(echo "# Linux version "$LINUXVER)
initrd $INITRD
chain $VMLINUZPATH ip=dhcp
boot
EOF
	# Copy the file
	if [ -d $IPXEPATH ]; then
		echo $IPXEPATH" exists, overwriting"
	else
		echo "Copying: "$IPXEPATH
		sudo -E cp -v $IPXEFILE $IPXEPATH
	fi
}

if [ $# -ge 1 ]; then
	buildIPXE $1
else
	echo "Using default NFS root"
	buildIPXE $(echo $BUILDNAME)
fi


