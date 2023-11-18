#!/bin/bash

set -eux

script_dir=$(dirname $(realpath $0))

${script_dir}/install/swapfile.sh
${script_dir}/install/systems.sh
${script_dir}/install/crypto.sh
${script_dir}/install/xkeysnail.sh
