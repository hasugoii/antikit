# Clean Code

> Nguyên tắc viết code sạch và maintainable

## Principles

### 1. Meaningful Names
```typescript
// ❌ Bad
const d = new Date();
const x = users.filter(u => u.a);

// ✅ Good
const currentDate = new Date();
const activeUsers = users.filter(user => user.isActive);
```

### 2. Small Functions
```typescript
// ❌ Function > 50 lines
// ✅ Tách thành nhiều functions nhỏ

function processOrder(order) {
  validateOrder(order);
  calculateTotal(order);
  saveOrder(order);
  sendNotification(order);
}
```

### 3. Single Responsibility
```typescript
// ❌ Class làm nhiều việc
// ✅ Mỗi class 1 responsibility

class UserRepository { }  // Data access
class UserService { }     // Business logic
class UserController { }  // HTTP handling
```

### 4. DRY (Don't Repeat Yourself)
Tách code lặp thành functions/components

### 5. KISS (Keep It Simple)
Giải pháp đơn giản nhất đúng là tốt nhất
