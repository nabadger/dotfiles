#!/usr/bin/env bash

# Set makeflags
sudo sed -i -e 's/^#MAKEFLAGS=.*/MAKEFLAGS="-j2"/' /etc/makepkg.conf

# Disable beep/bell
echo "blacklist pcspkr" | sudo tee /etc/modprobe.d/nobeep.conf
lsmod | egrep pcspkr && sudo rmmod pcspkr

# Copy over any customized etc configuration
#sudo cp etc/X11/xorg.conf.d/30-touchpad.conf /etc/X11/xorg.conf.d/30-touchpad.conf

# Set NTP
sudo bash -c 'cat > /etc/systemd/timesyncd.conf << EOF
[Time]
NTP=0.manjaro.pool.ntp.org
FallbackNTP=0.manjaro.pool.ntp.org 1.manjaro.pool.ntp.org 2.manjaro.pool.ntp.org 3.manjaro.pool.ntp.org
#RootDistanceMaxSec=5
#PollIntervalMinSec=32
#PollIntervalMaxSec=2048
EOF'

sudo systemctl enable systemd-timesyncd.service --now
sudo timedatectl set-ntp true

# GPG
sudo systemctl enable pcscd.service --now

# Docker
sudo systemctl enable docker.service --now
