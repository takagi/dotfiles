#!/bin/bash

set -x

if [ -e /swapfile ]; then
    sudo swapoff /swapfile
    sudo rm /swapfile
fi

set -e

sudo dd if=/dev/zero of=/swapfile bs=1M count=8192
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
if ! grep -q /swapfile /etc/fstab; then
    echo /swapfile swap swap defaults 0 0 | sudo tee -a /etc/fstab > /dev/null
fi
