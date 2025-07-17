# Use Node base image
FROM node:20-alpine

# Install needed packages
RUN apk add --no-cache bash

# Set working directory
WORKDIR /app

# Copy package files and install dependencies
COPY package.json package-lock.json* ./
RUN npm install --legacy-peer-deps

# Copy the rest of the code
COPY . .

# Expose default web dev server port
EXPOSE 8081

# Start Expo web server
CMD ["npx", "expo", "start", "--web"]
