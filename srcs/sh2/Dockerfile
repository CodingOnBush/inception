# Use Debian 11 as the base image
FROM debian:11

# Copy the shell script into the container
COPY hello2.sh /hello2.sh

# Set executable permission for the script
RUN chmod +x /hello2.sh

# Define the command to run the script when the container starts
CMD ["/hello2.sh"]