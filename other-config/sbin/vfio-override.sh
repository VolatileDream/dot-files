#!/bin/sh -e
# Override graphics card driver for an nvidia card.

DEVICES="0000:03:00.0 0000:03:00.1"

for DEV in $DEVICES ; do
    echo "vfio-pci" > /sys/bus/pci/devices/$DEV/driver_override
done

modprobe -i vfio-pci
