# Specify the base image
FROM node:24-alpine

# Set the working directory in the container
WORKDIR /usr/app

# Copy the package.json file to the container
COPY ./package.json ./

# Install some dependencies
RUN npm install

# Copy the application code to the container
COPY ./ ./






# Default command to run the application
CMD ["npm", "start"]