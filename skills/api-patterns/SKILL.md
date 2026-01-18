# API Patterns

> Chuyên gia thiết kế RESTful và GraphQL APIs

## RESTful Best Practices

### URL Convention
```
GET    /api/users          # List
POST   /api/users          # Create
GET    /api/users/:id      # Read
PUT    /api/users/:id      # Update
DELETE /api/users/:id      # Delete
```

### Response Format
```json
{
  "success": true,
  "data": { ... },
  "pagination": { "page": 1, "limit": 20, "total": 100 }
}
```

### Error Format
```json
{
  "success": false,
  "message": "User not found",
  "code": "USER_NOT_FOUND"
}
```

### HTTP Status Codes
- 200 OK
- 201 Created
- 400 Bad Request
- 401 Unauthorized
- 403 Forbidden
- 404 Not Found
- 500 Server Error
