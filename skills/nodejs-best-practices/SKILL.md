# Node.js Best Practices

> Best practices cho Node.js applications

## Project Structure

```
src/
├── config/      # Configuration
├── controllers/ # HTTP handlers
├── middlewares/ # Express middlewares
├── services/    # Business logic
├── repositories/# Data access
├── utils/       # Helpers
└── index.ts     # Entry point
```

## Error Handling

```typescript
// Custom error class
class AppError extends Error {
  constructor(
    public message: string,
    public statusCode: number
  ) {
    super(message);
  }
}

// Centralized handler
app.use((err, req, res, next) => {
  const statusCode = err.statusCode || 500;
  res.status(statusCode).json({
    success: false,
    message: err.message
  });
});
```

## Best Practices
- Use async/await
- Validate all inputs
- Use environment variables
- Proper logging (winston/pino)
- Graceful shutdown
