# Stage 1: Build the static website using Expo Web
FROM node:18 AS builder

# Set working directory
WORKDIR /app

# Copy only package files to install dependencies
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the app
COPY . .

# Install webpack config for export
RUN npm install --save-dev @expo/webpack-config

# Optional: Create a minimal webpack.config.js (Expo can auto-detect too)
RUN echo "module.exports = async function(env, argv) { const { withExpo } = require('@expo/webpack-config'); return await withExpo(env, argv); };" > webpack.config.js

# Export the web build
RUN npx expo export:web

# Stage 2: Serve using Nginx
FROM nginx:alpine

# Copy build files to Nginx's public directory
COPY --from=builder /app/dist /usr/share/nginx/html

# Expose HTTP port
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
