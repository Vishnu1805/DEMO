#!/bin/bash
echo "Running start_app.sh"

cd /home/ec2-user/sampleApp || exit

# Example: Start app using PM2 (preferred for production)
if command -v pm2 &> /dev/null; then
  echo "Starting app using PM2..."
  pm2 start npm --name "sampleApp" -- start
else
  echo "PM2 not found. Starting with 'npm start' in background..."
  nohup npm start > app.log 2>&1 &
fi
