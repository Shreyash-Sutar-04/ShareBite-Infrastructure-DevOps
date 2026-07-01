#!/bin/bash

set -e

echo "========================================="
echo "Jenkins + Docker Setup"
echo "========================================="

echo "Updating system packages..."
sudo apt update

echo "Installing Java and required packages..."
sudo apt install -y \
    fontconfig \
    openjdk-21-jdk \
    curl \
    wget \
    gnupg

echo "Java Version:"
java -version

echo "Adding Jenkins repository..."
sudo mkdir -p /etc/apt/keyrings

curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | \
sudo tee /etc/apt/keyrings/jenkins-keyring.asc > /dev/null

echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | \
sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt update

echo "Installing Jenkins..."
sudo apt install -y jenkins

echo "Installing Docker..."
sudo apt install -y docker.io

echo "Starting services..."
sudo systemctl enable --now docker
sudo systemctl enable --now jenkins

echo "Adding users to Docker group..."
sudo usermod -aG docker jenkins
sudo usermod -aG docker "$USER"

# Restart Jenkins after updating group permissions
sudo systemctl restart jenkins

echo
echo "========================================="
echo "Installation Completed"
echo "========================================="

echo
echo "Java Version"
java -version

echo
echo "Docker Status"
sudo systemctl status docker --no-pager

echo
echo "Jenkins Status"
sudo systemctl status jenkins --no-pager

echo
echo "Initial Jenkins Password"
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

echo
echo "Open in browser:"
echo "http://<YOUR-EC2-PUBLIC-IP>:8080"

echo
echo "Next Steps"
echo "1. Allow port 8080 in the EC2 Security Group."
echo "2. Reconnect to the server so Docker group permissions are applied."
echo "3. Verify Docker access using: docker ps"
echo "========================================="
