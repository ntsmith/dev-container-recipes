# Ubuntu with Custom User Dev Container

Ubuntu with a non-root 'ubuntu' user that has sudo access.

## Configuration

Uses a Dockerfile to create the user:

```dockerfile
FROM ubuntu:latest
RUN apt-get update && apt-get install -y sudo
RUN echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/ubuntu
```

```json
{
  "build": { "dockerfile": "Dockerfile" },
  "remoteUser": "ubuntu"
}
```

## When to Use

- Better security practices
- Matching production environments
- Testing permission-related code

## Benefits

- Non-root by default
- Sudo available when needed
- More realistic development environment
