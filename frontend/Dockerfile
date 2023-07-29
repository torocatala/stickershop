# Use an official Node runtime as the base image
FROM node:20

# Create app directory
RUN mkdir -p /app && chown -R node:node /app

# Switch to a non-root user
USER node

# Set the working directory in the container to /app
WORKDIR /app

# Copy package.json and package-lock.json to the workspace
COPY --chown=node:node package*.json ./

# Install the application dependencies
RUN npm install

# Copy the application files to the container
COPY --chown=node:node . .

# Make port 3000 available outside the container
EXPOSE 3000

# Start the application
CMD [ "npm", "start" ]