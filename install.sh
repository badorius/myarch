#!/bin/bash

# Exit if any error occurs
set -e

#ADD PATH VARS
WDIR=$(pwd)
HDIR=${WDIR}/myarch
PDIR=${HDIR}/playbooks

TSTMP=$(date +%s)

# Check if myarch exist
if [ -d "myarch" ]; then
  echo "Deleting myarch directory..."
  sudo rm -rf $WDIR/myarch
fi

#Enable multilib repo
# Enable multilib repo
sudo cp /etc/pacman.conf /etc/pacman.conf.backup.${TSTMP}
mline=$(grep -n "\\[multilib\\]" /etc/pacman.conf | cut -d: -f1)
rline=$(($mline + 1))
sudo sed -i ''$mline's|#\[multilib\]|\[multilib\]|g' /etc/pacman.conf
sudo sed -i ''$rline's|#Include = /etc/pacman.d/mirrorlist|Include = /etc/pacman.d/mirrorlist|g' /etc/pacman.conf

# Install required packages
echo "Installing basic packages..."
sudo pacman -Sy --noconfirm pacman-contrib reflector git ansible base-devel

# Update mirrors for optimal speedecho "Actualizando mirrors..."
sudo reflector --verbose --country 'France,Germany,Spain,' --latest 5 --sort rate --save /etc/pacman.d/mirrorlist

# Update the base system
sudo pacman -Syu --noconfirm

# Clone the configuration repository
echo "Cloning myarch repo..."
git clone https://github.com/badorius/myarch.git 


# Installing yay
echo "Installing yay from GITHUB..."
git clone https://aur.archlinux.org/yay.git $HDIR/tmp/yay
cd $HDIR/tmp/yay
makepkg -si --noconfirm
cd $HDIR
sudo rm -rf $HDIR/tmp/yay
# Run the Ansible playbook (optional)

if [ -f $PDIR/install_pacman_pkg.yml ]; then
    echo "Running the Ansible playbook..."
    ansible-playbook -i inventory $PDIR/main_playbook.yml --ask-become-pass
else
    echo "Ansible playbook not found. Initial setup complete."
fi

if [ -f $PDIR/install_aur_pkg.yml ]; then
    echo "Running the Ansible playbook..."
    ansible-playbook -i inventory $PDIR/main_playbook.yml
else
    echo "Ansible playbook not found. Initial setup complete."
fi
