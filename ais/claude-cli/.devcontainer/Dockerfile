FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y nodejs npm && \
    npm install -g @anthropic-ai/claude-code

USER ubuntu

WORKDIR /workspace
