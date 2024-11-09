# Use Node.js 14 as the base image
FROM node:14

# Set the working directory in the container
WORKDIR /app

# Copy the application code to the container
COPY app.js .

# Expose the application port
EXPOSE 3000

# Define the command to run the application
CMD ["node", "app.js"]