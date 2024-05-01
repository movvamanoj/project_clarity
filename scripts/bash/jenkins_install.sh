#!/bin/bash

# Function to install Jenkins
install_jenkins() {
    echo "Installing Jenkins..."
    if [ -x "$(command -v apt-get)" ]; then
        # For Debian/Ubuntu
        wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo apt-key add -
        sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
        apt-get update
        apt-get install -y jenkins
        systemctl start jenkins
        systemctl enable jenkins
    elif [ -x "$(command -v yum)" ]; then
        # For CentOS/Fedora
        wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
        rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
        yum install -y jenkins
        systemctl start jenkins
        systemctl enable jenkins
    elif [ -x "$(command -v dnf)" ]; then
        # For Fedora
        wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
        rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
        dnf install -y jenkins
        systemctl start jenkins
        systemctl enable jenkins
    elif [ -f "/etc/system-release" ] && grep -q "Amazon Linux" "/etc/system-release"; then
        # For Amazon Linux
        wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
        rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
        yum install -y jenkins
        systemctl start jenkins
        systemctl enable jenkins
    else
        echo "Unsupported package manager or Linux distribution. Jenkins installation failed."
        exit 1
    fi
    echo "Jenkins installation completed."
}

# Execute the function
install_jenkins
