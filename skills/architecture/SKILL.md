# Architecture

> Kiến trúc phần mềm và system design

## Patterns

### Layered Architecture
```
Presentation → Business Logic → Data Access → Database
```

### Clean Architecture
```
         ┌─────────────┐
         │  Entities   │ (Domain)
         └──────┬──────┘
         ┌──────▼──────┐
         │  Use Cases  │ (Application)
         └──────┬──────┘
         ┌──────▼──────┐
         │  Interface  │ (Adapters)
         └──────┬──────┘
         ┌──────▼──────┐
         │ Frameworks  │ (External)
         └─────────────┘
```

### Microservices
- Service per domain
- API Gateway
- Event-driven communication

## Scalability

- Horizontal scaling
- Load balancing
- Database sharding
- Caching strategies
- CDN for static assets
