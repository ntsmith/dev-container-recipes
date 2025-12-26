# Jupyter Ubuntu Dev Container

A full-featured data science environment with ML, Geo, and LaTeX support.

## What's Included

### Python Stack
- **Core**: numpy, pandas, matplotlib, scipy, seaborn, plotly
- **ML**: scikit-learn, tensorflow, sympy
- **Geo**: GeoPandas with GDAL/GEOS for geospatial analysis
- **Finance**: yfinance for stock market data

### LaTeX
- texlive-latex-recommended, texlive-latex-extra
- texlive-fonts-recommended, texlive-science
- Full support for notebook PDF export

### System
- Ubuntu 22.04 base
- Python 3 with virtual environment at `/opt/venv`
- Non-root `ubuntu` user with sudo access

## Quick Start

1. Open this folder in VSCode
2. Click "Reopen in Container" when prompted
3. Open any `.ipynb` file or create a new notebook

## Demo Notebooks

- `analysis.ipynb` - Data analysis examples
- `test.ipynb` - Environment verification
- `stocks.py` - Stock data utilities

## Ports

| Port | Service |
|------|---------|
| 8888 | Jupyter Lab |

## Virtual Environment

The container uses a virtual environment at `/opt/venv`. VSCode is configured to use this automatically.

To activate manually in terminal:
```bash
source /opt/venv/bin/activate
```

## Files

```
jupyter_ubuntu/
├── .devcontainer/
│   ├── devcontainer.json
│   └── Dockerfile
├── analysis.ipynb
├── test.ipynb
├── stocks.py
└── README.md
```
