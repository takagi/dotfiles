#!/bin/bash

set -eux

script_dir=$(dirname $(realpath $0))

if [ -z "${skip_swap:-}" ]; then
    ${script_dir}/install/swapfile.sh
fi
${script_dir}/install/systems.sh
if [ -z "${skip_crypto:-}" ]; then
    ${script_dir}/install/crypto.sh
fi
${script_dir}/install/xkeysnail.sh
