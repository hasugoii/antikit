# Testing Patterns

> Chuyên gia testing với Jest, Vitest, Playwright

## Unit Test Pattern (AAA)

```typescript
describe('UserService', () => {
  it('should create user', async () => {
    // Arrange
    const input = { email: 'test@example.com' };
    
    // Act
    const user = await userService.create(input);
    
    // Assert
    expect(user.email).toBe(input.email);
  });
});
```

## Mocking

```typescript
jest.mock('./database', () => ({
  prisma: {
    user: {
      create: jest.fn(),
      findUnique: jest.fn(),
    }
  }
}));
```

## E2E Test (Playwright)

```typescript
test('login flow', async ({ page }) => {
  await page.goto('/login');
  await page.fill('[name="email"]', 'user@test.com');
  await page.fill('[name="password"]', 'password');
  await page.click('button[type="submit"]');
  await expect(page).toHaveURL('/dashboard');
});
```

## Coverage Goals
- Unit: 80%+
- Integration: Key flows
- E2E: Happy paths
