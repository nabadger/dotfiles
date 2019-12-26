#!/usr/bin/env bash

# Absolute path this script is in
SCRIPTPATH=$(dirname "$(readlink -f "$0")")
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

# Setup openresolv
sudo cp "${SCRIPTPATH}/system-configs/update-resolv-conf.sh" /etc/openvpn

# Setup time
sudo systemctl enable systemd-timesyncd.service --now
sudo timedatectl set-ntp true

# Setup required groups
sudo usermod -a -G video $(whoami)
sudo usermod -a -G docker $(whoami)

# Enable Services
## GPG
sudo systemctl enable pcscd.service --now
sudo systemctl start pcscd.service

## Docker
sudo systemctl enable docker.service --now
sudo systemctl start docker.service

## Systemd-resolved
sudo systemctl enable systemd-resolved.service
sudo systemctl start systemd-resolved.service
