FROM ubuntu:latest

# Avoid interactive prompts during apt operations
ENV DEBIAN_FRONTEND=noninteractive

# Create a non-root user 'ubuntu' with sudo access
RUN apt-get update && \
    apt-get install -y sudo && \
    echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/ubuntu && \
    chmod 0440 /etc/sudoers.d/ubuntu && \
    rm -rf /var/lib/apt/lists/*