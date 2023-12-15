#!/bin/bash

# Function to check command success
check_command() {
    if [ $? -ne 0 ]; then
        echo "Error: $1 failed. Exiting."
        exit 1
    fi
}

# Remove existing Docker-related packages
for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do
    sudo apt-get remove -y $pkg
done

# Update package index
sudo apt-get update

# Install required packages to enable HTTPS repositories
sudo apt-get install -y ca-certificates curl gnupg

# Create directory for Docker keyrings
sudo install -m 0755 -d /etc/apt/keyrings

# Add Docker's official GPG key to the keyring
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add Docker repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update package index again
sudo apt-get update

# Install Docker
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Check Docker installation
check_command "Docker installation"

# Run a test container
sudo docker run hello-world
check_command "Test container execution"

# Restart Docker service
sudo systemctl restart docker
sudo service docker restart

# Add the current user to the docker group to run Docker without sudo
sudo usermod -aG docker $USER

echo "Docker installed successfully."

# Install Java (required for Jenkins)
sudo apt-get install -y openjdk-8-jdk

# Check Java installation
check_command "Java installation"

# Add Jenkins repository key
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -

# Add Jenkins repository
echo "deb http://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list

# Update package index
sudo apt-get update

# Install Jenkins
sudo apt-get install -y jenkins

# Check Jenkins installation
if systemctl status jenkins; then
    echo "Jenkins installed successfully."
    echo "Access Jenkins at http://localhost:8080"
else
    echo "Error: Jenkins installation failed. Exiting."
    exit 1
fi
