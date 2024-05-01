#!/bin/bash

# Function to install Maven
install_maven() {
    echo "Installing Maven..."
    if [ -x "$(command -v apt-get)" ]; then
        # For Debian/Ubuntu
        apt-get update
        apt-get install -y maven
    elif [ -x "$(command -v yum)" ]; then
        # For CentOS/Fedora
        yum install -y maven
    elif [ -x "$(command -v dnf)" ]; then
        # For Fedora
        dnf install -y maven
    elif [ -f "/etc/system-release" ] && grep -q "Amazon Linux" "/etc/system-release"; then
        # For Amazon Linux
        yum install -y maven
    else
        echo "Unsupported package manager or Linux distribution. Maven installation failed."
        exit 1
    fi
    echo "Maven installation completed."
}

# Execute the function
install_maven
