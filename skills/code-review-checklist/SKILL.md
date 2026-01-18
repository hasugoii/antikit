# Code Review Checklist

> Checklist review code hiệu quả

## General

```
[ ] Code compiles/runs?
[ ] Follows coding standards?
[ ] No obvious bugs?
[ ] Tests included?
```

## Logic

```
[ ] Edge cases handled?
[ ] Error handling proper?
[ ] No race conditions?
[ ] Correct algorithm?
```

## Security

```
[ ] Input validated?
[ ] Auth/authz checked?
[ ] No sensitive data logged?
[ ] No hardcoded secrets?
```

## Performance

```
[ ] No N+1 queries?
[ ] Proper indexing?
[ ] No memory leaks?
[ ] Efficient algorithms?
```

## Maintainability

```
[ ] Readable code?
[ ] Good naming?
[ ] Not over-engineered?
[ ] Documentation added?
```

## Feedback Template

```
✅ LGTM after minor changes

**Suggestions:**
- Line X: Consider using Y
- Line Z: Add error handling

**Questions:**
- Why did you choose A over B?
```
