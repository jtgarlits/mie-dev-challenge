# Use an official Node.js runtime as a parent image
FROM node:16

# Create a working directory inside the container
WORKDIR /usr/src/app

# Copy package*.json into the working directory
COPY package*.json ./

# Install npm dependencies
RUN npm install

# Copy the rest of your application files
COPY . .

# Expose port 3000 in the container
EXPOSE 3000

# By default, run "npm start"
CMD ["npm", "start"]
