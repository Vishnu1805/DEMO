# Step 1: Build the web-exported static files
FROM node:18 AS build

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .

# Export the app as static HTML/CSS/JS
RUN npx expo export:web

# Step 2: Serve it with Nginx
FROM nginx:alpine
COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
