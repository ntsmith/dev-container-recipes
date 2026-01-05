FROM debian:bookworm-slim

RUN apt-get update && \
    apt-get install -y curl jq && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace
