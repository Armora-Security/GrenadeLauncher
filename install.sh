#!/bin/bash

# install.sh
# Armora Server Environment - Core Installation Script
#
# WARNING: This script is part of a highly experimental and undefined testing environment.
# It is proprietary and intended for review purposes only, as specified in the LICENSE.txt.
# Running this script will make significant changes to your system.
# Proceed only if you fully understand its implications and accept all risks.
# The author and contributors are not responsible for any damage, data loss,
# or issues that may arise from its execution.

echo "███████╗ ██████╗ ███╗   ███╗ ██████╗ ██████╗  █████╗  ██████╗ ██╗   ██╗"
echo "██╔════╝██╔═══██╗████╗ ████║██╔════╝ ██╔══██╗██╔══██╗██╔═══██╗╚██╗ ██╔╝"
echo "█████╗  ██║   ██║██╔████╔██║██║  ███╗██████╔╝███████║██║   ██║ ╚████╔╝ "
echo "██╔══╝  ██║   ██║██║╚██╔╝██║██║   ██║██╔══██╗██╔══██║██║   ██║  ╚██╔╝  "
echo "███████╗╚██████╔╝██║ ╚═╝ ██║╚██████╔╝██║  ██║██║  ██║╚██████╔╝   ██║   "
echo "╚══════╝ ╚═════╝ ╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝    ╚═╝   "
echo "---------------------------------------------------------------------"
echo "Starting Armora Server Environment core installation..."
echo "---------------------------------------------------------------------"

# --- System Update and Upgrade ---
echo "--> Updating and upgrading system packages..."
sudo apt update && sudo apt upgrade -y
if [ $? -eq 0 ]; then
    echo "System update and upgrade completed successfully."
else
    echo "ERROR: System update/upgrade failed. Exiting."
    exit 1
fi
echo ""

# --- Install Nginx ---
echo "--> Installing Nginx web server..."
sudo apt install -y nginx
if [ $? -eq 0 ]; then
    sudo systemctl enable nginx
    sudo systemctl start nginx
    echo "Nginx installed and started successfully."
else
    echo "ERROR: Nginx installation failed."
    exit 1
fi
echo ""

# --- Install Docker and Docker Compose ---
echo "--> Installing Docker and Docker Compose..."

# Add Docker's official GPG key
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
if [ $? -ne 0 ]; then echo "ERROR: Failed to install Docker prerequisites. Exiting."; exit 1; fi

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
if [ $? -ne 0 ]; then echo "ERROR: Failed to add Docker GPG key. Exiting."; exit 1; fi

# Set up the stable repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
if [ $? -ne 0 ]; then echo "ERROR: Failed to set up Docker repository. Exiting."; exit 1; fi

# Install Docker packages
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
if [ $? -eq 0 ]; then
    # Add current user to the docker group
    echo "Adding current user ($USER) to the docker group..."
    sudo usermod -aG docker "$USER"
    echo "Docker installed successfully. Please reboot your system for Docker group changes to take effect."
else
    echo "ERROR: Docker installation failed."
    exit 1
fi
echo ""

# --- Configure Firewall (UFW) ---
echo "--> Configuring UFW firewall..."
sudo apt install -y ufw
if [ $? -eq 0 ]; then
    sudo ufw enable
    sudo ufw allow ssh
    sudo ufw allow http
    sudo ufw allow https
    echo "UFW enabled and rules for SSH, HTTP, HTTPS applied."
    echo "Current UFW status:"
    sudo ufw status verbose
else
    echo "ERROR: UFW installation failed. Skipping firewall configuration."
fi
echo ""

echo "---------------------------------------------------------------------"
echo "Armora Server Environment core installation script completed!"
echo "---------------------------------------------------------------------"
echo "IMPORTANT: A system reboot is HIGHLY RECOMMENDED for all changes,"
echo "especially Docker group membership, to take full effect."
echo "You can reboot now by typing: sudo reboot"
echo "---------------------------------------------------------------------"
