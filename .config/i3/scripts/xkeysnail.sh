#! /bin/bash

killall -q xkeysnail

xkeysnail ~/.config/xkeysnail/config.py \
    --device 'Masayuki Takagi plum47' \
    --watch \
    --quiet
