#!/bin/bash

# Function to install Grafana
install_grafana() {
    echo "Installing Grafana..."
    if [ -x "$(command -v apt-get)" ]; then
        # For Debian/Ubuntu
        apt-get update
        apt-get install -y grafana
        systemctl daemon-reload
        systemctl enable grafana-server
        systemctl start grafana-server
    elif [ -x "$(command -v yum)" ]; then
        # For CentOS/Fedora
        yum install -y https://dl.grafana.com/oss/release/grafana-8.2.1-1.x86_64.rpm
        systemctl daemon-reload
        systemctl enable grafana-server
        systemctl start grafana-server
    elif [ -x "$(command -v dnf)" ]; then
        # For Fedora
        dnf install -y grafana
        systemctl daemon-reload
        systemctl enable grafana-server
        systemctl start grafana-server
    elif [ -f "/etc/system-release" ] && grep -q "Amazon Linux" "/etc/system-release"; then
        # For Amazon Linux
        wget https://dl.grafana.com/oss/release/grafana-8.2.1-1.x86_64.rpm
        yum install -y grafana-8.2.1-1.x86_64.rpm
        systemctl daemon-reload
        systemctl enable grafana-server
        systemctl start grafana-server
        rm grafana-8.2.1-1.x86_64.rpm
    else
        echo "Unsupported package manager or Linux distribution. Grafana installation failed."
        exit 1
    fi
    echo "Grafana installation completed."
}

# Execute the function
install_grafana
