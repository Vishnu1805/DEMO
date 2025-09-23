#!/bin/bash
echo "Running install_dependencies.sh"

cd /home/ec2-user/sampleApp || exit

# Install Node.js dependencies (if package.json exists)
if [ -f package.json ]; then
  echo "Installing npm dependencies..."
  npm install
else
  echo "No package.json found. Skipping npm install."
fi
