#!/bin/bash

set -u

rules_dir=/etc/udev/rules.d

cat <<EOF | sudo tee ${rules_dir}/10-input.rules > /dev/null
KERNEL=="event*", NAME="input/%K", MODE="660", GROUP="input"
EOF

cat <<EOF | sudo tee ${rules_dir}/10-uinput.rules > /dev/null
KERNEL=="uinput", GROUP="uinput"
EOF

cat <<EOF | sudo tee /etc/modules-load.d/uinput.conf > /dev/null
uinput
EOF

if ! grep -q "^uinput:" /etc/group; then
    sudo groupadd uinput
    sudo usermod -aG input $USER
    sudo usermod -aG uinput $USER
fi
