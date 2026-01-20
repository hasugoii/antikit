# Documentation Templates

> Templates cho technical documentation

## README Template

```markdown
# Project Name

> One-line description

## Quick Start
\`\`\`bash
npm install && npm run dev
\`\`\`

## Features
- Feature 1
- Feature 2

## Configuration
| Env | Description | Required |
|-----|-------------|----------|
| DATABASE_URL | DB connection | Yes |

## Contributing
[Guidelines]
```

## API Doc Template

```markdown
## POST /api/users

**Description:** Create user

**Headers:**
- Authorization: Bearer {token}

**Body:**
\`\`\`json
{ "email": "string", "name": "string" }
\`\`\`

**Response:** 201
\`\`\`json
{ "id": "string", "email": "string" }
\`\`\`
```

## JSDoc Template

```typescript
/**
 * Create a new user
 * @param data - User creation data
 * @returns Created user object
 * @throws {AppError} If email exists
 */
```
