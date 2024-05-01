#!/bin/bash

# Function to install Git
install_git() {
    echo "Installing Git..."
    if [ -x "$(command -v apt-get)" ]; then
        # For Debian/Ubuntu
        apt-get update
        apt-get install -y git
    elif [ -x "$(command -v yum)" ]; then
        # For CentOS/Fedora
        yum install -y git
    elif [ -x "$(command -v dnf)" ]; then
        # For Fedora
        dnf install -y git
    elif [ -f "/etc/system-release" ] && grep -q "Amazon Linux" "/etc/system-release"; then
        # For Amazon Linux
        yum install -y git
    else
        echo "Unsupported package manager or Linux distribution. Git installation failed."
        exit 1
    fi
    echo "Git installation completed."
}

# Execute the function
install_git
