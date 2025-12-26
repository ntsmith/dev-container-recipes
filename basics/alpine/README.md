# Alpine Dev Containers

Minimal Alpine Linux containers demonstrating various devcontainer configuration patterns.

## Containers

| Container | Description |
|-----------|-------------|
| `alpine_bare` | Absolute minimum - just the image |
| `alpine_basic` | Adds a name to the config |
| `alpine_extension` | Adding VSCode extensions |
| `alpine_git` | With git installed |
| `alpine_nogit` | Explicitly without git |
| `alpine_mount` | Custom mount configurations |
| `alpine_named` | Named container instance |
| `alpine_tabsize` | Editor settings (tab size) |
| `alpine_user` | Custom user via Dockerfile |

## Why Alpine?

Alpine Linux is extremely lightweight (~5MB), making it ideal for:
- Fast container builds
- Minimal resource usage
- Learning devcontainer basics without extra complexity

## Quick Start

```bash
code basics/alpine/alpine_basic
```

Then "Reopen in Container" when prompted.

## Configuration Patterns

### Image-only (simplest)
```json
{ "image": "alpine" }
```

### With name
```json
{
  "name": "Basic Dev Container",
  "image": "alpine"
}
```

### With Dockerfile
```json
{
  "build": { "dockerfile": "Dockerfile" }
}
```
