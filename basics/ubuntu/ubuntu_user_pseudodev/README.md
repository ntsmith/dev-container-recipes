# Ubuntu User + Pseudo Dev Container

Combines custom 'ubuntu' user with the pseudo-devcontainer workaround.

## Configuration

Uses a Dockerfile for user creation, but container is started manually.

## Usage

1. Build and run the container manually:
   ```bash
   ./run-dev.sh
   ```

2. In VSCode: `Dev Containers: Attach to Running Container...`

3. Select the running container

## When to Use

- When standard devcontainers freeze or timeout
- Debugging devcontainer startup issues
- Need more control over container lifecycle

## See Also

- [ubuntu_pseudodev](../ubuntu_pseudodev/) - Root user variant
- [ubuntu_user](../ubuntu_user/) - Standard devcontainer with custom user
