#!/bin/bash
# Script to rebuild initramfs
update-initramfs -vu

#NOTE: Built files:
ls /boot/initrd.img*
ls /boot/vmlinuz*
