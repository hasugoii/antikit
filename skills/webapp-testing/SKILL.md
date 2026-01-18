# Webapp Testing

> E2E và integration testing cho web apps

## Playwright Setup

```typescript
import { test, expect } from '@playwright/test';

test('user can login', async ({ page }) => {
  await page.goto('/login');
  await page.fill('[name="email"]', 'test@example.com');
  await page.fill('[name="password"]', 'password');
  await page.click('button[type="submit"]');
  
  await expect(page).toHaveURL('/dashboard');
  await expect(page.locator('h1')).toContainText('Welcome');
});
```

## Common Patterns

```typescript
// Wait for element
await page.waitForSelector('.loaded');

// Screenshot on failure
await page.screenshot({ path: 'error.png' });

// Network mocking
await page.route('**/api/**', route => {
  route.fulfill({ json: mockData });
});
```

## Test Types

- Smoke: Critical paths work
- Regression: Features still work
- Visual: UI looks correct
- Accessibility: A11y compliance
