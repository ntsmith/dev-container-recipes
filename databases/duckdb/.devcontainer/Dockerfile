FROM debian:bookworm-slim

RUN apt-get update && \
    apt-get install -y curl unzip && \
    curl -fsSL https://github.com/duckdb/duckdb/releases/download/v1.1.3/duckdb_cli-linux-amd64.zip -o duckdb.zip && \
    unzip duckdb.zip -d /usr/local/bin && \
    rm duckdb.zip && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace