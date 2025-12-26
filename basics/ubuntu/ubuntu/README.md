# Ubuntu (Root) Dev Container

The simplest possible dev container - just Ubuntu with root access.

## Configuration

Uses `image` instead of `build` - no Dockerfile needed.

```json
{
  "name": "Ubuntu with custom user",
  "image": "ubuntu:latest",
  "remoteUser": "root"
}
```

## When to Use

- Quick experiments
- When you need unrestricted access
- Learning devcontainers basics

## When NOT to Use

- Production-like environments
- When testing user permission issues
- Security-sensitive work
