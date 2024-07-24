#!/bin/bash

# Update the package index
sudo apt update

# Install prerequisites
sudo apt install -y pass gnupg2 curl

# Remove any existing incorrect binary
sudo rm -f /usr/local/bin/docker-credential-pass

# Download the latest release for amd64
curl -LO https://github.com/docker/docker-credential-helpers/releases/download/v0.7.0/docker-credential-pass-linux-amd64

# Make the binary executable
chmod +x docker-credential-pass-linux-amd64

# Move the binary to a directory included in your PATH
sudo mv docker-credential-pass-linux-amd64 /usr/local/bin/docker-credential-pass

# Set up Docker to use the credential helper
mkdir -p ~/.docker
cat <<EOL > ~/.docker/config.json
{
  "credsStore": "pass"
}
EOL

# Prompt to log in to Docker Hub
echo "Please log in to Docker Hub to store your credentials securely."
docker login

echo "Docker credential helper setup completed."
 
