#!/bin/bash

# Function to install SonarQube
install_sonarqube() {
    echo "Installing SonarQube..."
    if [ -x "$(command -v apt-get)" ]; then
        # For Debian/Ubuntu
        wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-8.9.2.46101.zip
        unzip sonarqube-8.9.2.46101.zip -d /opt
        ln -s /opt/sonarqube-8.9.2.46101 /opt/sonarqube
        useradd --no-create-home --shell /bin/false sonarqube
        chown -R sonarqube:sonarqube /opt/sonarqube
        cp /opt/sonarqube/bin/linux-x86-64/sonar.sh /etc/init.d/sonarqube
        chmod 755 /etc/init.d/sonarqube
        update-rc.d sonarqube defaults
        /etc/init.d/sonarqube start
    elif [ -x "$(command -v yum)" ]; then
        # For CentOS/Fedora
        wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-8.9.2.46101.zip
        unzip sonarqube-8.9.2.46101.zip -d /opt
        ln -s /opt/sonarqube-8.9.2.46101 /opt/sonarqube
        useradd --no-create-home --shell /bin/false sonarqube
        chown -R sonarqube:sonarqube /opt/sonarqube
        cp /opt/sonarqube/bin/linux-x86-64/sonar.sh /etc/init.d/sonarqube
        chmod 755 /etc/init.d/sonarqube
        systemctl daemon-reload
        systemctl enable sonarqube
        systemctl start sonarqube
    elif [ -x "$(command -v dnf)" ]; then
        # For Fedora
        wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-8.9.2.46101.zip
        unzip sonarqube-8.9.2.46101.zip -d /opt
        ln -s /opt/sonarqube-8.9.2.46101 /opt/sonarqube
        useradd --no-create-home --shell /bin/false sonarqube
        chown -R sonarqube:sonarqube /opt/sonarqube
        cp /opt/sonarqube/bin/linux-x86-64/sonar.sh /etc/init.d/sonarqube
        chmod 755 /etc/init.d/sonarqube
        systemctl daemon-reload
        systemctl enable sonarqube
        systemctl start sonarqube
    elif [ -f "/etc/system-release" ] && grep -q "Amazon Linux" "/etc/system-release"; then
        # For Amazon Linux
        wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-8.9.2.46101.zip
        unzip sonarqube-8.9.2.46101.zip -d /opt
        ln -s /opt/sonarqube-8.9.2.46101 /opt/sonarqube
        useradd --no-create-home --shell /bin/false sonarqube
        chown -R sonarqube:sonarqube /opt/sonarqube
        cp /opt/sonarqube/bin/linux-x86-64/sonar.sh /etc/init.d/sonarqube
        chmod 755 /etc/init.d/sonarqube
        systemctl daemon-reload
        systemctl enable sonarqube
        systemctl start sonarqube
    else
        echo "Unsupported package manager or Linux distribution. SonarQube installation failed."
        exit 1
    fi
    echo "SonarQube installation completed."
}

# Execute the function
install_sonarqube
