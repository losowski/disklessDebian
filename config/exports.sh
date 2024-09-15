#!/usr/bin/bash
export HOSTFILES=$PWD/host
# Build Roots
export BUILDROOTIMAGE=$PWD/image
export BUILDTEMPLATE=$PWD/imageTemplate
# Get version
export BUILDVERSION=$(cat /etc/os-release | grep "^VERSION_CODENAME" | cut -d '=' -f 2 | sed 's#"##g')
export VERSION_ID=$(cat /etc/os-release | grep "^VERSION_ID" | cut -d '=' -f 2 | sed 's#"##g')
export ID=$(cat /etc/os-release | grep "^ID" | cut -d '=' -f 2 | sed 's#"##g')
# OS Image Version
export MODEL="base"
# OS BuildName
export BUILDNAME=$(echo $ID$VERSION_ID"-"$MODEL)