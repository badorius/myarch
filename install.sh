#!/bin/bash

# Exit if any error occurs
set -e

# Check if tmp/yay exist
if [ -d "myarch" ]; then
  echo "Deleting myarch directory..."
  rm -rf myarch
fi

# Install required packages
echo "Installing basic packages..."
sudo pacman -Sy --noconfirm pacman-contrib reflector git ansible base-devel

# Update mirrors for optimal speedecho "Actualizando mirrors..."
sudo reflector --verbose --latest 5 --sort rate --save /etc/pacman.d/mirrorlist

# Update the base system
sudo pacman -Syu --noconfirm

# Clone the configuration repository
echo "Clonando el repositorio..."
git clone https://github.com/badorius/myarch.git 

# Navigate to the cloned directory
cd myarch


# Check if tmp/yay exist
if [ -d "tmp/yay" ]; then
  echo "Deleting tmp/yay..."
  rm -rf tmp/yay
fi

# Installing yay
echo "Installing yay from GITHUB..."
git clone https://aur.archlinux.org/yay.git tmp/yay
cd tmp/yay
makepkg -si --noconfirm
rm -rf tmp/yay
# Run the Ansible playbook (optional)

if [ -f playbook.yml ]; then
    echo "Running the Ansible playbook..."
    ansible-playbook -i inventory playbook.yml --ask-become-pass
else
    echo "Ansible playbook not found. Initial setup complete."
fi
