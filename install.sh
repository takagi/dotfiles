#!/bin/bash

set -u
script_dir=$(dirname $(realpath $0))

set -x
${script_dir}/install/systems.sh
${script_dir}/install/xkeysnail.sh
