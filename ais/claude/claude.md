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

## Project Context

<!-- Customize this section per-project -->

When starting work on a new project, understand:
- Directory structure and where different code lives
- Existing patterns for the type of change you're making
- Test organization and how to run them
- Build/lint/format commands

---

## Notes

- This file is version controlled — update it as preferences evolve
- Project-specific overrides can go in a local `.claude` directory
