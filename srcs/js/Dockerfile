FROM node:14

# Set working directory
WORKDIR /app

# Copy package.json first (to leverage Docker's layer caching)
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy application code
COPY . .

# Start the application
CMD ["node", "app.js"]
