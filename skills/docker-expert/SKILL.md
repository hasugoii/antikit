# Docker Expert

> Chuyên gia Docker và containerization

## Dockerfile Best Practices

```dockerfile
# Multi-stage build
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production

FROM node:20-alpine AS runner
WORKDIR /app
COPY --from=builder /app/node_modules ./node_modules
COPY . .
USER node
CMD ["node", "dist/index.js"]
```

## Docker Compose

```yaml
version: '3.8'
services:
  app:
    build: .
    ports:
      - "3000:3000"
    environment:
      - DATABASE_URL=${DATABASE_URL}
    depends_on:
      - db
  db:
    image: postgres:15-alpine
    volumes:
      - pgdata:/var/lib/postgresql/data
volumes:
  pgdata:
```

## Tips
- Use .dockerignore
- Use alpine images
- Multi-stage builds
- Don't run as root
