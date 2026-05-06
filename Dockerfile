# Specify the base image
FROM alpine

# Install Node.js and npm
RUN npm install

# Default command to run the application
CMD ["npm", "start"]
s