#!/bin/bash
# Build the IPXE file for NFS

# Build IPXE
# 1	-	Verion (base
buildIPXE () {
	# mk path
	FULLPATH=$(echo "../host/home/tftp/"$1 )
	# Describe actions
	echo "Building: "$build
	if [ -d $FULLPATH ]; then
		echo $FULLPATH" exists, overwriting"
	else
		echo "Making new directory: "$FULLPATH
		mkdir -p $FULLPATH
	fi
	# Linux Version
	LINUXVER=$(ls -1 ../image/boot/vmlinuz*| sed 's/^.*\///g' | cut -d '-' -f 2)
	# Get image build from LIVE ../image/boot/
	# IPXE path
	IPXEPATH=$(echo $FULLPATH"/netboot.ipxe" )
	INITRD=$(ls -1 ../image/boot/initrd* | sed 's/^.*\///g' )
	VMLINUZ=$(ls -1 ../image/boot/vmlinuz*| sed 's/^.*\///g' )
	NFSPATH="/home/nfs/"$1"/root"
	VMLINUZPATH=$(echo $VMLINUZ" nfsroot="$NFSPATH" ro panic=60")
cat > $(echo $IPXEPATH) << EOF
#!ipxe
$(echo "# IPXE Netboot configuration for build: "$1)
$(echo "# Linux version "$LINUXVER)
kernel $VMLINUZ
root=/dev/nfs $INITRD \
$VMLINUZPATH
EOF
}

if [ $# -ge 1 ]; then
	for build in $@; do buildIPXE $1; shift; done
else
	echo "Using default NFS root"
	buildIPXE "basic"
fi


