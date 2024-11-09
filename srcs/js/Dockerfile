FROM debian:11

# Set working directory
WORKDIR /app

COPY hello.js ./

# Install dependencies
RUN npm install

# Copy application code
COPY . .

# Start the application
CMD ["node", "hello.js"]
