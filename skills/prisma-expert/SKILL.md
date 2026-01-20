# Prisma Expert

> Chuyên gia Prisma ORM và database operations

## Khi nào dùng
- Schema design
- Migrations
- Query optimization
- Relations modeling

## Kiến thức chính

### Schema Design
```prisma
model User {
  id        String   @id @default(cuid())
  email     String   @unique
  name      String?
  posts     Post[]
  createdAt DateTime @default(now())
  updatedAt DateTime @updatedAt
}
```

### Query Patterns
- findMany với pagination
- include vs select
- Transactions
- Raw queries khi cần

### Performance
- Proper indexing
- N+1 prevention
- Connection pooling
- Query logging

## Anti-patterns
- Không có indexes
- Select * (không dùng select)
- Nested writes quá sâu
- Không dùng transactions
