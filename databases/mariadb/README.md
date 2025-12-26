# MariaDB Dev Container

A MySQL-compatible SQL database running in a VSCode Dev Container with Jupyter Lab.

## What's Included

- **MariaDB** - Popular open-source SQL database
- **Jupyter Lab** - Interactive notebook environment
- **Python** - With mysql-connector for database access

## Quick Start

1. Open this folder in VSCode
2. Click "Reopen in Container" when prompted
3. Wait for MariaDB service to start
4. Open `maria_demo.ipynb` and run the cells

## Demo

The included notebook demonstrates:
- Connecting to MariaDB
- Creating a database and table
- Inserting and querying data

## Ports

| Port | Service |
|------|---------|
| 8888 | Jupyter Lab |
| 3306 | MariaDB |

## Connection Details

- **Host**: mariadb (from container) or localhost (from host)
- **Port**: 3306
- **User**: root
- **Password**: (check docker-compose.yml)

## Files

```
mariadb/
├── .devcontainer/
│   ├── devcontainer.json
│   ├── docker-compose.yml
│   └── Dockerfile
├── maria_demo.ipynb       # Demo notebook
└── README.md
```
