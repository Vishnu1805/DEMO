# Step 1: Build stage using Node.js
FROM node:18 AS builder

WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy all source code
COPY . .

# Force install the compatible webpack config (avoiding peer conflict)
RUN npm install --save-dev @expo/webpack-config --legacy-peer-deps

# Optional: generate default webpack.config.js if missing
RUN echo "module.exports = async function(env, argv) { const { withExpo } = require('@expo/webpack-config'); return await withExpo(env, argv); };" > webpack.config.js

# Export the static web app (output goes to /app/dist)
RUN npx expo export:web

# Step 2: Serve stage using Nginx
FROM nginx:alpine

# Copy build output to Nginx's public directory
COPY --from=builder /app/dist /usr/share/nginx/html

# Expose port and start server
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
