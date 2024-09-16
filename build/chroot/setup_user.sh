#!/usr/bin/bash
# Script to setup the users
if [ $# -ge 1]; then
	useradd -m --password $1 $1
else
	echo "Set a user"
fi
