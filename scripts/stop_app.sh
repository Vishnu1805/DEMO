#!/bin/bash
echo "Running stop_app.sh"

# Stop app using PM2 if available
if command -v pm2 &> /dev/null; then
  echo "Stopping app with PM2..."
  pm2 stop sampleApp || true
else
  echo "No PM2. Killing npm/node process..."
  pkill -f "node" || true
fi
