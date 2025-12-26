# Redis Dev Container

An in-memory key-value store running in a VSCode Dev Container with Jupyter Lab.

## What's Included

- **Redis** - High-performance in-memory data store
- **Jupyter Lab** - Interactive notebook environment
- **Python** - With redis-py for database access

## Quick Start

1. Open this folder in VSCode
2. Click "Reopen in Container" when prompted
3. Wait for Redis service to start
4. Open `redis_demo.ipynb` and run the cells

## Demo

The included notebook demonstrates:
- Connecting to Redis
- Setting and getting key-value pairs
- Working with different data types

## Ports

| Port | Service |
|------|---------|
| 8888 | Jupyter Lab |
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
├── redis_demo.ipynb       # Demo notebook
└── README.md
```
