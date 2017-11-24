#!/bin/sh
# Install this into sbin, chown to root:root, and set the attributes
# to u=rwx, g=rx, o=r

# List of devices to release from pci-stub, this allows them to be claimed by
# pci-stub initially, and then released to the nvidia driver to use by the
# host system.
#
# Otherwise, pci-stub appears to be unable to grab the video component of the
# graphics cards.
#
# address can be found using "lspci -nnvvv"
# Can also be found using nvidia-settings (look for the GPU info & bus id)
DEVICES="0000:02:00.0 0000:02:00.1"

for DEV in ${DEVICES} ; do
    echo "pci-stub" > "/sys/bus/pci/devices/${DEV}/driver_override"
done

# This is the install script for pci-stub, we need to modprobe the module
# without recursively invoking ourselves again.
modprobe -i pci-stub
