# Specify the base image
FROM node:24-alpine

# Set the working directory in the container
WORKDIR /usr/app

# Copy the application code to the container
COPY ./ ./


# Install some dependencies
RUN npm install



# Default command to run the application
CMD ["npm", "start"]