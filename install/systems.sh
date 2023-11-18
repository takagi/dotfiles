#!/bin/bash

set -eux

script_dir=$(dirname $(realpath $0))
pkgname_dir=${script_dir}/../pkgname

# yay packages
if [ -z "${skip_yay:-}" ]; then
    if [ -n "${noconfirm:-}" ]; then
        confirm_opt='--noconfirm --answerdiff=None'
    else
        confirm_opt=''
    fi
    yay -Syu ${confirm_opt}
    cat ${pkgname_dir}/yay.list | yay -S --needed ${confirm_opt} -
    if lscpu | grep -q AMD; then
        list=yay.list.amd
    elif lscpu | grep -q Intel; then
        list=yay.list.intel
    else
        echo 'Unsupported CPU vendor' >&2
        exit 1
    fi
    cat ${pkgname_dir}/${list} | yay -S --needed ${confirm_opt} -
    if lspci | grep -iq nvidia; then
        cat ${pkgname_dir}/yay.list.nvidia | yay -S --needed ${confirm_opt} -
    fi
    #yay -S --needed ${confirm_opt} spotify
fi

# sshd
wget https://github.com/takagi.keys -O ~/.ssh/authorized_keys
sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
sudo systemctl restart sshd.service

# lightdm
sudo systemctl enable lightdm
sudo sed -i 's/#greeter-session=example-gtk-gnome/greeter-session=lightdm-slick-greeter/' /etc/lightdm/lightdm.conf

# lightdm-slick-greeter
sudo cp ${script_dir}/../submodules/wallpapers/wallpaper.jpg /etc/lightdm/wallpaper.jpg
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
    cat <<EOF | sudo tee -a /etc/environment > /dev/null
GTK_IM_MODULE=fcitx
QT_IM_MODULE=fcitx
XMODIFIERS=@im=fcitx
EOF
fi

# asciiquarium: change castle's color
sudo sed -i "s/default_color\t=> 'BLACK',/default_color\t=> 'WHITE',/" /usr/bin/asciiquarium

# blahaj
cargo install display3d
if ! [ -d $HOME/wrk/display3d ]; then
    pushd ~/wrk/
    git clone https://github.com/redpenguinyt/display3d.git
    popd
fi

# emacs as root
if ! sudo grep -q make-backup-files /root/.emacs; then
    cat <<EOF | sudo tee -a /root/.emacs > /dev/null
;;; No backup
(setq make-backup-files nil)
EOF
fi

# .bashrc.local
if ! grep -q .bashrc.local $HOME/.bashrc; then
    cat <<'EOF' >> $HOME/.bashrc
# .bashrc.local
source $HOME/.bashrc.local
EOF
fi

# starship
if ! grep -q starship $HOME/.bashrc; then
    cat <<'EOF' >> $HOME/.bashrc
# starship
eval $(starship init bash)
EOF
fi

# updatedb.conf
if ! sudo grep -q zenlog /etc/updatedb.conf; then
    sudo sed -i '/^PRUNEPATHS = "/ s/"$/ \/home\/mtakagi\/.cache \/home\/mtakagi\/.zenlog"/' /etc/updatedb.conf 
fi

# todoist_mail
if ! [ -d $HOME/wrk/todoist_mail ]; then
    pushd ~/wrk/
    git clone git@github.com:takagi/todoist_mail.git
    cd todoist_mail
    cargo build --release
    popd
fi
