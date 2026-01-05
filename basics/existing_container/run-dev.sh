#!/usr/bin/env bash
set -euo pipefail

# Name of the dev container
NAME=dev-ubuntu

# Kill any old one
if docker ps -a --format '{{.Names}}' | grep -q "^${NAME}$"; then
  docker rm -f "${NAME}" >/dev/null 2>&1 || true
fi

docker run -d \
  --name "${NAME}" \
  --mount type=bind,source=/home/login/myprog/dev-container-recipes,target=/workspaces/dev-container-recipes \
  -w /workspaces/dev-container-recipes/vscode/ubuntu \
  ubuntu:latest \
  sleep infinity
