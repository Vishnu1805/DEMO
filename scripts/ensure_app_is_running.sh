#!/bin/bash
echo "Running ensure_app_is_running.sh"

# Check if PM2 process is running
if command -v pm2 &> /dev/null; then
  pm2 show sampleApp
else
  pgrep -f "node"
  if [ $? -eq 0 ]; then
    echo "App is running."
  else
    echo "App is NOT running!"
    exit 1
  fi
fi
