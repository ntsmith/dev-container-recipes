FROM debian:bookworm-slim

RUN apt-get update && \
    apt-get install -y redis-tools && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace
