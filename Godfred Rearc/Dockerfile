# Use an official Node.js runtime as a parent image
FROM node:14

# Set the working directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY index.js .

# Set environment variable
ENV SECRET_WORD=your_secret_word

# Expose the port the app runs on
EXPOSE 8080

# Define environment variables
ENV PORT=8080
ENV NODE_ENV=production

# Start the app
CMD ["node", "index.js"]
