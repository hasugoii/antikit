# TDD Workflow

> Test-Driven Development workflow

## Red-Green-Refactor

```
1. RED: Write failing test
2. GREEN: Write minimal code to pass
3. REFACTOR: Improve code
4. Repeat
```

## Example

```typescript
// 1. RED - Write test first
describe('add', () => {
  it('should add two numbers', () => {
    expect(add(2, 3)).toBe(5);
  });
});

// 2. GREEN - Minimal implementation
function add(a: number, b: number): number {
  return a + b;
}

// 3. REFACTOR (if needed)
// Already clean, move on
```

## Benefits

- Better design (testable code)
- Documentation (tests as specs)
- Confidence (regression protection)
- Focus (one thing at a time)

## Tips

- Small tests
- One assertion per test
- Test behaviors, not implementation
- Run tests frequently
