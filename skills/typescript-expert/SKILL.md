# TypeScript Expert

> Chuyên gia TypeScript với advanced types

## Kiến thức chính

### Utility Types
```typescript
Partial<T>    // Tất cả optional
Required<T>   // Tất cả required
Pick<T, K>    // Chọn một số keys
Omit<T, K>    // Bỏ một số keys
Record<K, V>  // Object với keys K, values V
```

### Generics
```typescript
function getProperty<T, K extends keyof T>(obj: T, key: K): T[K] {
  return obj[key];
}
```

### Type Guards
```typescript
function isString(x: unknown): x is string {
  return typeof x === 'string';
}
```

### Discriminated Unions
```typescript
type Result<T> = 
  | { success: true; data: T }
  | { success: false; error: string };
```

## Best Practices
- Prefer `unknown` over `any`
- Use strict mode
- Leverage inference
- Document complex types
