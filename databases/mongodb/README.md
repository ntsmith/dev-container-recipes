# MongoDB Dev Container

A NoSQL document database with the MongoDB shell.

## What's Included

- **MongoDB** - Document-oriented NoSQL database
- **mongosh** - MongoDB shell for interactive queries
- **MongoDB VSCode Extension** - For browsing collections

## Quick Start

1. Open this folder in VSCode
2. Click "Reopen in Container" when prompted
3. Wait for MongoDB service to start
4. Run the demo: `mongosh mongodb://mongodb:27017 demo.js`

Or use mongosh interactively:

```bash
mongosh mongodb://mongodb:27017
```

## Demo

The included script demonstrates:
- Inserting documents
- Querying and filtering data
- Working with multiple documents

## Ports

| Port | Service |
|------|---------|
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
├── demo.js                # Demo script
└── README.md
```
