# MariaDB Dev Container

A MySQL-compatible SQL database with the MySQL CLI.

## What's Included

- **MariaDB** - Popular open-source SQL database
- **mysql** - MySQL command-line client

## Quick Start

1. Open this folder in VSCode
2. Click "Reopen in Container" when prompted
3. Wait for MariaDB service to start
4. Run the demo: `mysql -h mariadb -u user -ppassword demo_db < demo.sql`

Or use mysql interactively:

```bash
mysql -h mariadb -u user -ppassword demo_db
```

## Demo

The included script demonstrates:
- Creating tables
- Inserting data
- Querying with filters and aggregations

## Ports

| Port | Service |
|------|---------|
| 3306 | MariaDB |

## Connection Details

- **Host**: mariadb (from container) or localhost (from host)
- **Port**: 3306
- **Database**: demo_db
- **User**: user
- **Password**: password

## Files

```
mariadb/
├── .devcontainer/
│   ├── devcontainer.json
│   ├── docker-compose.yml
│   └── Dockerfile
├── demo.sql               # Demo script
└── README.md
```
