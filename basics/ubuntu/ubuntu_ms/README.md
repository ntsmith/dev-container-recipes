# Microsoft Base Ubuntu Dev Container

Uses Microsoft's official devcontainer base image with pre-configured tooling.

## Configuration

```json
{
  "image": "mcr.microsoft.com/devcontainers/base:ubuntu-24.04",
  "remoteUser": "vscode"
}
```

## What's Included

Microsoft's base image comes with:
- Git
- Common utilities (curl, wget, etc.)
- 'vscode' user with sudo access
- Proper shell configuration

## When to Use

- Starting new projects quickly
- When you want common tools pre-installed
- Following Microsoft's recommended patterns

## Image Variants

- `ubuntu-24.04` - Latest Ubuntu LTS
- `ubuntu-22.04` - Previous Ubuntu LTS
- `debian` - Debian-based alternative
