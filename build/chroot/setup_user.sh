#!/bin/bash
# Script to setup a single user
if [ $# -eq 1 ]; then
	echo "Setting user account \"$1\""
	if [ $# -eq 2 ]; then
		useradd -m --password $1 $2
	else
		useradd -m --password $1 $1
	fi
else
	echo "Set a user"
fi
