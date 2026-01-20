# Database Design

> Chuyên gia thiết kế database schema

## Normalization

### 1NF: Atomic values
### 2NF: No partial dependencies  
### 3NF: No transitive dependencies

## Schema Design Checklist

```
[ ] Primary keys (cuid/uuid)
[ ] Foreign keys with indexes
[ ] createdAt/updatedAt
[ ] Soft delete (deletedAt)
[ ] Unique constraints
[ ] Default values
```

## Relationships

```prisma
// 1-to-Many
model User {
  id    String @id
  posts Post[]
}

model Post {
  userId String
  user   User @relation(fields: [userId], references: [id])
}

// Many-to-Many
model Post {
  tags PostTag[]
}

model Tag {
  posts PostTag[]
}

model PostTag {
  postId String
  tagId  String
  @@id([postId, tagId])
}
```

## Performance
- Index frequently queried columns
- Composite indexes for multi-column queries
- Avoid over-indexing
