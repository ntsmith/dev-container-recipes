# Ubuntu Dev Containers

Reference configurations exploring different user/permission models for dev containers.

## Available Containers

| Container | Base Image | User | Use Case |
|-----------|-----------|------|----------|
| `ubuntu` | ubuntu:latest | root | Simplest possible config |
| `ubuntu_user` | ubuntu:latest | ubuntu | Custom non-root user via Dockerfile |
| `ubuntu_ms` | mcr.microsoft.com/devcontainers/base | vscode | Microsoft's pre-built devcontainer base |
| `ubuntu_pseudodev` | (manual) | - | Workaround for attach-to-container |
| `ubuntu_user_pseudodev` | ubuntu:latest | ubuntu | Combined user + pseudo-dev |

## When to Use Each

### Root User (`ubuntu`)
- Quick experiments
- When you need full system access
- Not recommended for production-like environments

### Custom Non-Root User (`ubuntu_user`)
- Better security practices
- Matches typical deployment environments
- Requires Dockerfile to create user

### Microsoft Base Image (`ubuntu_ms`)
- Pre-configured with common dev tools
- Uses 'vscode' user by default
- Good starting point for new projects

### Pseudo Dev Container (`ubuntu_pseudodev`, `ubuntu_user_pseudodev`)
- Workaround when devcontainers freeze
- Run container manually, then attach from VSCode
- Useful for debugging devcontainer issues

## User Configuration Options

```json
{
  "remoteUser": "ubuntu",           // User VSCode runs as
  "updateRemoteUserUID": false,     // Don't remap UID
  "userEnvProbe": "none"            // Skip environment probing
}
```
