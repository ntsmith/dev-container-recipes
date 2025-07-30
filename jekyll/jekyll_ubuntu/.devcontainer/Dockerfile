FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

# Create non-root user matching VS Code Dev Containers convention
RUN apt-get update && apt-get install -y \
    curl \
    git \
    ruby-full \
    build-essential \
    libffi-dev \
    libyaml-dev \
    nodejs \
    npm \
 && rm -rf /var/lib/apt/lists/*

# Create a user for VS Code
RUN useradd -m vscode && echo "vscode ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Set default shell environment
USER vscode
WORKDIR /home/vscode

# Install bundler and github-pages gem (in project dir later)
