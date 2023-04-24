# Base Image
FROM node:14-alpine

# Set working directory
WORKDIR /app

# Copy application files
COPY . .

# Copy package.json and package-lock.json
# COPY package.json ./

# Install dependencies
RUN yarn install

# Expose port 3000 for the app
EXPOSE 4000

# Start the app
CMD ["yarn", "dev"]