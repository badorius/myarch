#!/bin/bash

# Exit if any error occurs
set -e

#ADD PATH VARS
WDIR=$(pwd)
HDIR=${WDIR}/myarch

# Check if myarch exist
if [ -d "myarch" ]; then
  echo "Deleting myarch directory..."
  rm -rf $WDIR/myarch
fi

# Install required packages
echo "Installing basic packages..."
sudo pacman -Sy --noconfirm pacman-contrib reflector git ansible base-devel

# Update mirrors for optimal speedecho "Actualizando mirrors..."
sudo reflector --verbose --latest 5 --sort rate --save /etc/pacman.d/mirrorlist

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
rm -rf $HDIR/tmp/yay
# Run the Ansible playbook (optional)

if [ -f $HDIR/playbook.yml ]; then
    echo "Running the Ansible playbook..."
    ansible-playbook -i inventory playbook.yml --ask-become-pass
else
    echo "Ansible playbook not found. Initial setup complete."
fi
