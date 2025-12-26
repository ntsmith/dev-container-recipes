# Python Dev Containers

Various Python development environment configurations.

## Containers

| Container | Description |
|-----------|-------------|
| `python` | Basic Python with requirements.txt |
| `python_venv` | Python with virtual environment |
| `python_autopep8` | With autopep8 formatter |
| `python_autopep8_pylint` | autopep8 + pylint linting |
| `python_jupyter` | Python with Jupyter notebooks |
| `python_scipynotebook` | Scientific Python (scipy, numpy) |
| `python_tabsize` | Editor settings configuration |
| `poetry_hello` | Poetry package manager example |

## Progression

Start simple and add complexity as needed:

1. **python** - Just Python and pip
2. **python_venv** - Add virtual environment isolation
3. **python_autopep8** - Add code formatting
4. **python_autopep8_pylint** - Add linting
5. **python_jupyter** - Add notebook support

## Quick Start

```bash
code lang/python/python_venv
```

Then "Reopen in Container" when prompted.

## Common Patterns

### requirements.txt
```dockerfile
COPY requirements.txt .
RUN pip install -r requirements.txt
```

### Virtual environment
```dockerfile
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
```

### Linting extensions
```json
{
  "customizations": {
    "vscode": {
      "extensions": ["ms-python.python"]
    }
  }
}
```
