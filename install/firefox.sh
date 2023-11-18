#!/bin/bash

set -eux

if ! lscpu | grep -q AMD; then
    exit 0
fi

# Initialize profile folders
firefox --headless &
pid=$!
sleep 1
kill $pid
wait

# Place configuration to enable VAAPI
profile_dir=$(realpath $(ls -d ~/.mozilla/firefox/*.default-release))
cat <<EOF > ${profile_dir}/user.js
user_pref("media.ffmpeg.vaapi.enabled", true);
EOF
