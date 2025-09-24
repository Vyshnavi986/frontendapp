# Use Node.js base image
FROM node:22

WORKDIR /app

COPY package*.json ./
RUN npm install -g live-server

COPY . .

# Expose port 80 instead of 8080
EXPOSE 80

# Run live-server on port 80
CMD ["live-server", "--port=80", "--host=0.0.0.0", "."]
