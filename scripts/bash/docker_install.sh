#!/bin/bash

# Function to install Docker
install_docker() {
    echo "Installing Docker..."
    if [ -x "$(command -v apt-get)" ]; then
        # For Debian/Ubuntu
        apt-get update
        apt-get install -y docker.io
    elif [ -x "$(command -v yum)" ]; then
        # For CentOS/Fedora
        yum install -y docker
    elif [ -x "$(command -v dnf)" ]; then
        # For Fedora
        dnf install -y docker
    elif [ -f "/etc/system-release" ] && grep -q "Amazon Linux" "/etc/system-release"; then
        # For Amazon Linux
        yum install -y docker
    else
        echo "Unsupported package manager or Linux distribution. Docker installation failed."
        exit 1
    fi
    echo "Docker installation completed."
}

# Execute the function
install_docker
