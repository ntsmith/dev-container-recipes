# Jekyll Markdown Dev Container

Jekyll with enhanced markdown support for notes and documentation.

## What's Included

- **Jekyll** - Static site generator
- **Kramdown** - Advanced markdown processor
- **GitHub-Flavored Markdown** - Tables, task lists, fenced code blocks
- **MathJax** - Mathematical notation rendering
- **Minima Theme** - Clean, minimal design
- **Live Reload** - Auto-refresh on file changes

## Quick Start

1. Open this folder in VSCode
2. Click "Reopen in Container" when prompted
3. Jekyll starts automatically and serves the site
4. Open http://localhost:4000 in your browser

## Demo

- `index.md` - Homepage in markdown
- `notes/example.md` - Example note with markdown features

## Ports

| Port | Service |
|------|---------|
| 4000 | Jekyll server |

## Markdown Features

### Math (MathJax)
```
$$E = mc^2$$
```

### Fenced Code
```python
def hello():
    print("Hello, World!")
```

### Tables
```
| Column 1 | Column 2 |
|----------|----------|
| Data 1   | Data 2   |
```

## Commands

Jekyll starts automatically. To restart manually:
```bash
bundle exec jekyll serve --livereload --host 0.0.0.0
```

## Files

```
jekyll_markdown/
├── .devcontainer/
│   ├── devcontainer.json
│   └── Dockerfile
├── _config.yml        # Jekyll configuration
├── Gemfile
├── Gemfile.lock
├── index.md           # Homepage
├── notes/             # Markdown notes
├── _site/             # Generated output
└── README.md
```
