# Python Patterns

> Best practices cho Python development

## Project Structure

```
project/
├── src/
│   ├── __init__.py
│   ├── main.py
│   └── modules/
├── tests/
├── requirements.txt
└── pyproject.toml
```

## Common Patterns

```python
# Type hints
def get_user(user_id: int) -> User | None:
    pass

# Dataclasses
@dataclass
class User:
    id: int
    name: str
    email: str

# Context managers
with open('file.txt') as f:
    content = f.read()

# List comprehension
squares = [x**2 for x in range(10)]

# Dictionary comprehension
counts = {word: len(word) for word in words}
```

## Best Practices

- Use virtual environments
- Type hints (mypy)
- Follow PEP 8
- Docstrings for public APIs
- Exception handling
