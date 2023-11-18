#!/bin/bash

set -u

script_dir=$(dirname $(realpath $0))
pkgname_dir=${script_dir}/../pkgname

if [ -z "${skip_yay}" ]; then
    cat ${pkgname_dir}/yay.list | yay -Sy --noconfirm --answerdiff=None -
fi

set -x

# sshd
wget https://github.com/takagi.keys -O ~/.ssh/authorized_keys
sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
sudo systemctl restart sshd.service

# lightdm
sudo systemctl enable lightdm
sudo sed -i 's/#greeter-session=example-gtk-gnome/greeter-session=lightdm-slick-greeter/' /etc/lightdm/lightdm.conf

# lightdm-slick-greeter
sudo cp ${script_dir}/../wallpapers/wallpaper.jpg /etc/lightdm/wallpaper.jpg
cat <<EOF | sudo tee /etc/lightdm/slick-greeter.conf > /dev/null
[Greeter]
background=/etc/lightdm/wallpaper.jpg
EOF

# DPMS
cat <<EOF | sudo tee /etc/X11/xorg.conf.d/10-monitor.conf > /dev/null
Section "Monitor"
    Identifier "LVDS0"
    Option "DPMS" "true"
EndSection

Section "ServerLayout"
    Identifier "ServerLayout0"
    Option "StandbyTime" "0"
    Option "SuspendTime" "0"
    Option "OffTime"     "15"
    Option "BlankTime"   "0"
EndSection
EOF

# Fcitx 5
if ! grep -q fcitx /etc/environment; then
    cat <<EOF | sudo tee /etc/environment > /dev/null
GTK_IM_MODULE=fcitx
QT_IM_MODULE=fcitx
XMODIFIERS=@im=fcitx
EOF
fi

# asciiquarium: change castle's color
sudo sed -i "s/default_color\t=> 'BLACK',/default_color\t=> 'WHITE',/" /usr/bin/asciiquarium
