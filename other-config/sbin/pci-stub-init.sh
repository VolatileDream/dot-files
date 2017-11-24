#!/bin/sh
# Install this into sbin, chown to root:root, and set the attributes to u=rwx, g=rx, o=r

# List of devices to override with pci-stub, this allows them to be claimed
# by a guest VM, and avoid issues with being initialized by the host.
# _SECOND_ nvidia GPU (and audio subcomponent)
# address can be found using "lspci -nnvvv"
# Can also be found using nvidia-settings (look for the GPU info & bus id)
DEVICES="0000:03:00.0 0000:03:00.1"

for DEV in ${DEVICES} ; do
    echo "pci-stub" > "/sys/bus/pci/devices/${DEV}/driver_override"
done

# This is the install script for pci-stub, we need to modprobe the module
# without recursively invoking ourselves again.
modprobe -i pci-stub
