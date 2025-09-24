# Use Node.js base image
FROM node:20

# Set working directory
WORKDIR /app

# Copy package.json and install dependencies
COPY package*.json ./
RUN npm install -g live-server

# Copy all project files
COPY . .

# Expose port 3000 (matches host mapping)
EXPOSE 3000

# Run live-server on 0.0.0.0 so it's accessible outside container
CMD ["live-server", "--port=3000", "--host=0.0.0.0", "."]
