# Specify the base image
FROM node:24-alpine

# Install some dependencies
WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

# Default command to run the application
CMD ["npm", "start"]