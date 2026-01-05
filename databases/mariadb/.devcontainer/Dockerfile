FROM debian:bookworm-slim

RUN apt-get update && \
    apt-get install -y default-mysql-client && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace