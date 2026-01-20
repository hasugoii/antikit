# Parallel Agents

> Điều phối nhiều agents làm việc song song

## Khi nào dùng

- Task phức tạp cần nhiều chuyên môn
- Có thể chia thành subtasks độc lập
- Cần output từ nhiều perspectives

## Coordination Pattern

```
Orchestrator
    │
    ├─→ @frontend (UI tasks)
    │
    ├─→ @backend (API tasks)
    │
    └─→ @database (Schema tasks)
    
    ↓ Sync Point
    
Result Merge
```

## Execution Modes

### Parallel (independent tasks)
```
Task A ──→ Agent 1 ──┐
Task B ──→ Agent 2 ──┼──→ Merge
Task C ──→ Agent 3 ──┘
```

### Sequential (dependent tasks)
```
Task A ──→ Agent 1 ──→ Task B ──→ Agent 2 ──→ Result
```

## Conflict Resolution

- API contracts agreed first
- Shared interfaces defined
- Review by orchestrator
