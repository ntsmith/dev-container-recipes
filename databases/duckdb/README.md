# DuckDB Dev Container

An embedded analytics database with SQL support.

## What's Included

- **DuckDB CLI** - High-performance embedded SQL database

## Quick Start

1. Open this folder in VSCode
2. Click "Reopen in Container" when prompted
3. Run the demo: `duckdb < demo.sql`

Or use DuckDB interactively:

```bash
duckdb
```

## Demo

The included script demonstrates:
- Loading CSV data directly with SQL
- Running queries with filters
- Aggregations

## Files

```
duckdb/
├── .devcontainer/
│   ├── devcontainer.json
│   └── Dockerfile
├── demo.sql               # Demo script
├── sample_data.csv        # Sample data
└── README.md
```
