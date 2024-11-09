FROM debian:11

# Set working directory
WORKDIR /app

COPY hello.js ./

# Install dependencies
RUN apt-get update && apt-get install -y nodejs npm

# Copy application code
COPY . .

# Start the application
CMD ["node", "hello.js"]
