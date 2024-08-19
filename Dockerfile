# Use the Piston image from the official repository
FROM ghcr.io/engineer-man/piston:latest

# Set environment variables for the Piston container (if needed)
ENV PISTON_MAX_TIMEOUT=10
ENV PISTON_MAX_MEMORY=256

# Expose the port used by Piston
EXPOSE 2000

# Create directories for volumes
RUN mkdir -p /piston/packages /piston/jobs /tmp

# Mount the volumes (this is handled when running the container, not in the Dockerfile)
VOLUME /piston/packages
VOLUME /piston/jobs
VOLUME /tmp

# Start the Piston API
CMD ["piston", "start"]
