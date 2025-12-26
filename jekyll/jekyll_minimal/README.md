# Jekyll Minimal Dev Container

A minimal Jekyll setup for building static sites.

## What's Included

- **Jekyll** - Static site generator
- **Ruby** - Runtime environment
- **Live Reload** - Auto-refresh on file changes

## Quick Start

1. Open this folder in VSCode
2. Click "Reopen in Container" when prompted
3. Jekyll starts automatically and serves the site
4. Open http://localhost:4000 in your browser

## Demo

The container includes a basic `index.html` as a starting point.

## Ports

| Port | Service |
|------|---------|
| 4000 | Jekyll server |

## Commands

Jekyll starts automatically. To restart manually:
```bash
bundle exec jekyll serve --livereload --host 0.0.0.0
```

Build without serving:
```bash
bundle exec jekyll build
```

## Files

```
jekyll_minimal/
├── .devcontainer/
│   ├── devcontainer.json
│   └── Dockerfile
├── Gemfile
├── Gemfile.lock
├── index.html         # Demo page
├── _site/             # Generated output
└── README.md
```
