#!/bin/bash

set -eux

script_dir=$(dirname $(realpath $0))

${script_dir}/install/firefox.sh
