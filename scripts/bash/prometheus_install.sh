#!/bin/bash

# Function to install Prometheus
install_prometheus() {
    echo "Installing Prometheus..."
    if [ -x "$(command -v apt-get)" ]; then
        # For Debian/Ubuntu
        apt-get update
        apt-get install -y prometheus
    elif [ -x "$(command -v yum)" ]; then
        # For CentOS/Fedora
        yum install -y prometheus
    elif [ -x "$(command -v dnf)" ]; then
        # For Fedora
        dnf install -y prometheus
    elif [ -f "/etc/system-release" ] && grep -q "Amazon Linux" "/etc/system-release"; then
        # For Amazon Linux
        wget https://github.com/prometheus/prometheus/releases/download/v2.30.3/prometheus-2.30.3.linux-amd64.tar.gz
        tar -xzf prometheus-2.30.3.linux-amd64.tar.gz -C /opt
        ln -s /opt/prometheus-2.30.3.linux-amd64 /opt/prometheus
        rm prometheus-2.30.3.linux-amd64.tar.gz
        useradd --no-create-home --shell /bin/false prometheus
        chown -R prometheus:prometheus /opt/prometheus
        cp /opt/prometheus/prometheus /usr/local/bin/
        cp /opt/prometheus/promtool /usr/local/bin/
        mkdir /etc/prometheus
        cp /opt/prometheus/prometheus.yml /etc/prometheus/
        chown -R prometheus:prometheus /etc/prometheus
        cp /opt/prometheus/prometheus.service /etc/systemd/system/
        systemctl daemon-reload
        systemctl enable prometheus
        systemctl start prometheus
    else
        echo "Unsupported package manager or Linux distribution. Prometheus installation failed."
        exit 1
    fi
    echo "Prometheus installation completed."
}

# Execute the function
install_prometheus
