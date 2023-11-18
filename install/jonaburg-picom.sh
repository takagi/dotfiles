#!/bin/bash

set -eux

if [ -d ~/wrk/picom ]; then
   exit 0
fi

cd ~/wrk
git clone https://github.com/jonaburg/picom.git
cd picom
meson --buildtype=release . build
ninja -C build
