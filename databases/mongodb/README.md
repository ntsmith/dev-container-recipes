# MongoDB Dev Container

A NoSQL document database running in a VSCode Dev Container with Jupyter Lab.

## What's Included

- **MongoDB** - Document-oriented NoSQL database
- **Jupyter Lab** - Interactive notebook environment
- **Python** - With pymongo for database access
- **MongoDB VSCode Extension** - For browsing collections

## Quick Start

1. Open this folder in VSCode
2. Click "Reopen in Container" when prompted
3. Wait for MongoDB service to start
4. Open `mongo_demo.ipynb` and run the cells

## Demo

The included notebook demonstrates:
- Connecting to MongoDB
- Inserting documents
- Querying and filtering data

## Ports

| Port | Service |
|------|---------|
| 8888 | Jupyter Lab |
| 27017 | MongoDB |

## Connection Details

- **Host**: mongodb (from container) or localhost (from host)
- **Port**: 27017
- **Connection String**: `mongodb://mongodb:27017`

## Files

```
mongodb/
├── .devcontainer/
│   ├── devcontainer.json
│   ├── docker-compose.yml
│   └── Dockerfile
├── mongo_demo.ipynb       # Demo notebook
└── README.md
```
