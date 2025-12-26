FROM ubuntu:latest

# Avoid interactive prompts during apt operations
ENV DEBIAN_FRONTEND=noninteractive

# Use the non-root user 'ubuntu' with sudo access
RUN apt-get update \
    && apt-get install -y sudo \
    && rm -rf /var/lib/apt/lists/*

RUN echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/ubuntu && \
    chmod 0440 /etc/sudoers.d/ubuntu