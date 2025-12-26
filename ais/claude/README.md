# Claude Code Dev Container

A development environment with Claude Code CLI pre-installed.

## What's Included

- **Ubuntu** - Linux base image
- **Node.js** - JavaScript runtime
- **Claude Code** - Anthropic's CLI for Claude AI
- **Claude Code VSCode Extension** - IDE integration

## Quick Start

1. Open this folder in VSCode
2. Click "Reopen in Container" when prompted
3. Use Claude Code from the terminal or VSCode command palette

## Usage

### Terminal
```bash
claude "your prompt here"
```

### VSCode
Use the Claude Code extension from the command palette (Ctrl/Cmd + Shift + P).

## Configuration

The `claude.md` file contains instructions for Claude's behavior in this workspace.

## Files

```
claude/
├── .devcontainer/
│   ├── devcontainer.json
│   └── Dockerfile
├── claude.md          # Claude instructions
└── README.md
```

## Requirements

You'll need an Anthropic API key. Set it as an environment variable:
```bash
export ANTHROPIC_API_KEY=your-key-here
```

Or configure it through the Claude Code CLI:
```bash
claude config
```
