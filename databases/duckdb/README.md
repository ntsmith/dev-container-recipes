# DuckDB Dev Container

An embedded analytics database with SQL support, running in a VSCode Dev Container with Jupyter Lab.

## What's Included

- **DuckDB** - High-performance embedded SQL database
- **Jupyter Lab** - Interactive notebook environment
- **Python** - With pandas, numpy for data analysis

## Quick Start

1. Open this folder in VSCode
2. Click "Reopen in Container" when prompted
3. Open `duckdb_demo.ipynb` and run the cells

## Demo

The included notebook demonstrates:
- Loading CSV data into DuckDB
- Running SQL queries
- Working with query results in pandas

## Ports

| Port | Service |
|------|---------|
| 8888 | Jupyter Lab |

## Files

```
duckdb/
├── .devcontainer/
│   ├── devcontainer.json
│   ├── Dockerfile
│   └── requirements.txt
├── duckdb_demo.ipynb      # Demo notebook
├── sample_data.csv        # Sample data
└── README.md
```
