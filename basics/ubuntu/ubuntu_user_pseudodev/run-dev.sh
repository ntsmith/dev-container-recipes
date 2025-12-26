#!/usr/bin/env bash
set -euo pipefail

# --- Config --------------------------------------------------------------

# Name for the image and container
IMAGE_NAME="ubuntu_user_pseudodev-image:latest"
CONTAINER_NAME="ubuntu_user_pseudodev-container"

# Project root on the host (directory containing this script)
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Where your Dockerfile lives
# e.g. .devcontainer/Dockerfile relative to the project root
DOCKERFILE_PATH="${PROJECT_ROOT}/.devcontainer/Dockerfile"

# Container paths
CONTAINER_WORKSPACE_ROOT="/workspaces/project"
CONTAINER_WORKDIR="${CONTAINER_WORKSPACE_ROOT}"

# ------------------------------------------------------------------------#

echo "Building image: ${IMAGE_NAME}"
docker build \
  -f "${DOCKERFILE_PATH}" \
  -t "${IMAGE_NAME}" \
  "${PROJECT_ROOT}"

# Remove any old container with the same name
if docker ps -a --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
  echo "Removing existing container: ${CONTAINER_NAME}"
  docker rm -f "${CONTAINER_NAME}" >/dev/null 2>&1 || true
fi

echo "Starting container: ${CONTAINER_NAME}"
docker run -d \
  --name "${CONTAINER_NAME}" \
  --mount type=bind,source="${PROJECT_ROOT}",target="${CONTAINER_WORKSPACE_ROOT}" \
  -w "${CONTAINER_WORKDIR}" \
  "${IMAGE_NAME}" \
  sleep infinity

echo
echo "Container '${CONTAINER_NAME}' is running."
echo "In VS Code, run: 'Dev Containers: Attach to Running Container...'"
echo "Then choose '${CONTAINER_NAME}', and select folder:"
echo "  ${CONTAINER_WORKSPACE_ROOT}"
