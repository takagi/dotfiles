#! /bin/bash

killall -q xkeysnail

while pgrep -u $UID -x xkeysnail >/dev/null; do sleep 1; done

xkeysnail ~/.config/xkeysnail/config.py \
    --device 'Masayuki Takagi plum47' \
    --watch \
    --quiet
