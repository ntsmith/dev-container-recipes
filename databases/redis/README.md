# Redis Dev Container

An in-memory key-value store with the Redis CLI.

## What's Included

- **Redis** - High-performance in-memory data store
- **redis-cli** - Command-line interface for Redis

## Quick Start

1. Open this folder in VSCode
2. Click "Reopen in Container" when prompted
3. Wait for Redis service to start
4. Run the demo: `./demo.sh`

Or use redis-cli interactively:

```bash
redis-cli -h redis
```

## Demo

The included script demonstrates:
- Setting and getting key-value pairs
- Storing JSON data
- Working with hashes

## Ports

| Port | Service |
|------|---------|
| 6379 | Redis |

## Connection Details

- **Host**: redis (from container) or localhost (from host)
- **Port**: 6379

## Files

```
redis/
├── .devcontainer/
│   ├── devcontainer.json
│   ├── docker-compose.yml
│   └── Dockerfile
├── demo.sh                # Demo script
└── README.md
```
