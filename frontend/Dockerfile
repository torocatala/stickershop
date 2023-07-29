# Use an official Node runtime as the base image
FROM node:20

# Set the working directory in the container to /app
WORKDIR /app

# Copy package.json and package-lock.json to the workspace
COPY package*.json ./

# Install the application dependencies
RUN npm install

# Copy the application files to the container
COPY . .

# Make port 3000 available outside the container
EXPOSE 3000

# Start the application
CMD [ "npm", "start" ]
