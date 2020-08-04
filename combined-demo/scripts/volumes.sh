#!/bin/bash

# mount ebs volume to a dir.

sudo mkfs.ext4 ${DEVICE}

mkdir -p /data

echo `${DEVICE} /data ext4 defaults 0 0` >> /etc/fstab

mount /data
