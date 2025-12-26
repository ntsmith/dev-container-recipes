# Claude Instructions

## Core Principles

1. **Simplicity First** — Write minimal code that solves the problem. No premature abstraction, no "just in case" features. YAGNI.
2. **Test-Driven** — Scaffold stub → write failing test → implement. Tests prove behavior, not coverage metrics.
3. **Type Safety** — Use the type system fully. Avoid `any`, `unknown` escape hatches, and unsafe casts.

---

## Interaction Style

- **Balanced approach**: Ask clarifying questions for complex or ambiguous tasks. Proceed directly when intent is clear.
- **Make reasonable assumptions** when facing uncertainty — note what you assumed so I can correct if needed.
- **Be concise**: Skip preamble, avoid verbose explanations. Get to the point.

---

## Things to NEVER Do

- **Over-comment**: No obvious comments, no docstrings for self-explanatory code. Comments are for *why*, not *what*.
- **Premature abstraction**: Don't extract functions/classes for one-time code. Three similar lines > unnecessary helper.
- **Over-engineer**: No feature flags, config options, or extensibility for hypothetical futures.
- **Pad responses**: No "Great question!" or "I'd be happy to help!" — just help.

---

## Code Standards

### All Languages
- Follow existing project conventions (formatting, naming, structure)
- Prefer pure functions and immutability where practical
- Keep functions small and focused on one task
- Name things clearly — if you need a comment to explain what something does, rename it

### TypeScript/JavaScript
- `import type { ... }` for type-only imports
- Prefer `type` over `interface` unless merging is needed
- Branded types for IDs when beneficial

### Python
- Type hints everywhere
- Prefer dataclasses/Pydantic over raw dicts
- Follow existing project structure (src layout, tests location)

### Go/Rust
- Follow idiomatic patterns for the language
- Handle errors explicitly, no silent failures

---

## Testing

- **Colocate unit tests** with source files (`*.spec.ts`, `*_test.go`, `test_*.py`)
- **Integration > heavy mocking** — test real behavior when practical
- **Test descriptions match assertions** — if they don't align, fix one
- **No trivial tests** — `expect(2).toBe(2)` is worthless
- **Test edge cases**: empty inputs, boundaries, error conditions

---

## Git

Use **Conventional Commits**:
```
<type>[scope]: <description>

[optional body]
```

Types: `feat`, `fix`, `refactor`, `test`, `docs`, `chore`, `perf`, `ci`

Examples:
- `feat(auth): add OAuth2 login flow`
- `fix: handle null user in profile page`
- `refactor(api): simplify request validation`

**Do NOT include AI attribution** in commit messages (no "Generated with Claude" or co-author lines).

---

## Shortcuts

### `xplan`
Analyze the task and propose an approach:
- Check for similar patterns in the codebase
- List files that need changes
- Note any ambiguities or decisions needed
- Keep changes minimal and consistent with existing code

### `xcode`
Implement the plan:
- Follow TDD: stub → failing test → implementation
- Run tests to verify nothing broke
- Run formatters/linters if project has them

### `xcheck`
Self-review as a skeptical senior engineer:
- Is this the simplest solution?
- Are there unnecessary abstractions or over-engineering?
- Do tests actually verify meaningful behavior?
- Any type safety holes or error handling gaps?

### `xgit`
Stage, commit, and push:
- Use Conventional Commits format
- Write clear, concise commit message
- Don't reference AI/Claude in the message

### `xtests`
Run the test suite and fix any failures:
- Run relevant tests for changed code
- If tests fail, diagnose and fix
- Report final status

### `xlint`
Run linters/type checkers and fix issues:
- Run project's configured linters
- Fix auto-fixable issues
- Report remaining problems

---

## Project Context: Dev Container Recipes

This is a **POC/demo collection** of VSCode Dev Container configurations. Each container should demonstrate a working setup that users can learn from and adapt.

### Directory Structure

```
/                       # Root devcontainer (Ubuntu + Claude Code)
├── basics/             # Minimal reference configurations
│   ├── alpine/         # Alpine Linux patterns (9 containers)
│   └── ubuntu/         # Ubuntu user/permission models (5 containers)
├── databases/          # Database containers with Jupyter demos
│   ├── duckdb/         # Embedded analytics DB
│   ├── mariadb/        # SQL database
│   ├── mongodb/        # NoSQL document DB
│   └── redis/          # Key-value store
├── jupyter/            # Jupyter notebook environments
│   └── jupyter_ubuntu/ # ML/Geo stack with LaTeX
├── kafka/              # Message broker with Zookeeper
├── jekyll/             # Static site generators
│   ├── jekyll_minimal/
│   └── jekyll_markdown/
├── lang/               # Language-specific environments
│   └── python/         # Python configurations (8 containers)
└── claude/             # Claude Code CLI environment
```

### Standard Container Structure

Each container MUST have:
```
container_name/
├── .devcontainer/
│   ├── devcontainer.json    # Required - container config
│   └── Dockerfile           # Required - image definition
├── docker-compose.yml       # Optional - multi-service setups
├── README.md                # Required - setup/usage docs
├── .gitignore               # Required - ignore build artifacts
└── demo.ipynb / demo.sh     # Required - working demonstration
```

### devcontainer.json Essentials

```json
{
  "name": "Descriptive Name",
  "build": { "dockerfile": "Dockerfile" },
  "forwardPorts": [8888],
  "customizations": {
    "vscode": {
      "extensions": ["relevant.extension"]
    }
  },
  "remoteUser": "ubuntu"
}
```

For multi-service (databases, kafka):
```json
{
  "dockerComposeFile": "../docker-compose.yml",
  "service": "dev",
  "workspaceFolder": "/workspace"
}
```

### Demo Requirements

Each container demo should:
1. **Be self-contained** - Work immediately after container starts
2. **Show core functionality** - Create, read, update, delete operations
3. **Include comments** - Explain what's happening for learning
4. **Handle errors gracefully** - Show proper error handling patterns

Database demos: Create DB/table → Insert data → Query data → Clean up
Service demos: Start service → Produce/consume → Verify → Teardown

### Dockerfile Patterns

```dockerfile
# Use specific versions, not :latest
FROM ubuntu:22.04

# Set non-interactive for apt
ENV DEBIAN_FRONTEND=noninteractive

# Combine RUN commands to reduce layers
RUN apt-get update && apt-get install -y \
    package1 \
    package2 \
    && rm -rf /var/lib/apt/lists/*

# Create non-root user
RUN useradd -m ubuntu
USER ubuntu
WORKDIR /workspace
```

### Current Work Focus

1. **Test existing containers** - Verify each demo works
2. **Fix broken containers** - Repair as needed
3. **Add missing demos** - Every container needs a working demo
4. **Expand coverage** - Add new containers from wishlist

### Containers to Add (from prompts.md)

- express - Node.js web framework
- slurm - HPC job scheduler
- haskell - Functional programming
- rust - Systems programming
- java - JDK environment

### Testing Containers

To test a container:
1. Open folder in VSCode: `code databases/duckdb`
2. "Reopen in Container" when prompted
3. Run the demo (notebook or script)
4. Verify expected output

---

## Notes

- This file is version controlled — update it as preferences evolve
- Project-specific overrides can go in a local `.claude` directory
