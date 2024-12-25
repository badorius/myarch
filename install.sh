#!/bin/bash

# Exit if any error occurs
set -e

# Install required packages
echo "Installing basic packages..."
pacman -Sy --noconfirm pacman-contrib reflector git ansible

# Update mirrors for optimal speedecho "Actualizando mirrors..."
reflector --verbose --latest 5 --sort rate --save /etc/pacman.d/mirrorlist

# Update the base system
pacman -Syu --noconfirm

# Clone the configuration repository
echo "Clonando el repositorio..."
git clone https://github.com/badorius/myarch.git 

# Navigate to the cloned directory
cd myarch

# Run the Ansible playbook (optional)

if [ -f playbook.yml ]; then
    echo "Running the Ansible playbook..."
    ansible-playbook -i inventory playbook.yml --ask-become-pass
else
    echo "Ansible playbook not found. Initial setup complete."
fi
