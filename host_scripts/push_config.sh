#!/bin/bash
# Script to copy the configuration over to the host system
# Assume there is no-prexisting configuration to overwrite- and replace with scricter configuration
# TODO: Implement this via rsync
# TODO: use configuration files from "host" directory (should be in same directory tree)
# TODO: Perform service restarts too
# NFS Server restart
systemctl restart nfs-server