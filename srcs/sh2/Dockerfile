# Use Debian 11 as the base image
FROM debian:11

# Copy the shell script into the container
COPY hello.sh /hello.sh

# Set executable permission for the script
RUN chmod +x /hello.sh

# Define the command to run the script when the container starts
CMD ["/hello.sh"]