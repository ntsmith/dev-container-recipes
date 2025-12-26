FROM ubuntu:latest

# Install Node 22 (the current recommended LTS)
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash -
RUN apt-get update \
    && apt-get install -y nodejs npm \
    && apt-get clean && rm -rf /var/lib/apt/lists/*
RUN npm install -g @anthropic-ai/claude-code

USER ubuntu

WORKDIR /workspace
