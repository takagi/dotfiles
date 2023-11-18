#!/bin/bash

set -eux

name=$(lsblk --fs --list | grep crypto_LUKS | tr -s ' ' | cut -d' ' -f1)

# Bind a LUKS volume to the TPM
if ! sudo cryptsetup luksDump "/dev/${name}" | grep -q clevis; then
    sudo clevis luks bind -d "/dev/${name}" tpm2 '{}'
    newly_bound=1
fi

# Regenerate the initramfs
if [ -n "${newly_bound:-}" ]; then
    sudo dracut -f
fi
