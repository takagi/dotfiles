#! /bin/bash

# Terminate an already running instance
pid=$(pgrep -u $UID -fo "$0")
if [ $$ -ne $pid ]; then
    kill $pid; sleep 1
fi

# Set random background every 10 minutes
while true; do
  feh --randomize --no-fehbg --bg-fill ~/.config/i3/wallpapers/DSCF5263.JPG
#  feh --randomize --no-fehbg --bg-fill ~/.config/i3/wallpapers/*.{jpg,JPG}
  sleep 10m
done
