#!/usr/bin/env bash

USER="devl"

echo "Running init script"

echo "[01] Setting the timezone"
sudo rm -f /etc/localtime
sudo ln -sf /usr/share/zoneinfo/Europe/Stockholm /etc/localtime

echo "[02] Linking /etc/hostname to /boot/hostname"
sudo rm -f /etc/hostname
sudo ln -sf /boot/etc/hostname /etc/hostname
echo -e "\tAfter a reboot, this host will be known as '$(cat /etc/hostname)'"

echo "[03] Linking /etc/hosts to /boot/hosts"
sudo rm -f /etc/hosts
sudo ln -sf /boot/etc/hosts /etc/hosts

echo "[04] Creating a new user called '${USER}'"
sudo adduser $USER
groups | sed 's/pi //g' | sed -e "s/ /,/g" | xargs -I{} sudo usermod -a -G {} $USER

echo "[05] Expanding the root file system to use the entire SD card"
sudo raspi-config nonint do_expand_rootfs

echo "[Done] Rebooting in 5 seconds. Please log in again as the new user and run the setup script"
sleep 5
sudo reboot
