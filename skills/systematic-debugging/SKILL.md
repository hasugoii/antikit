# Systematic Debugging

> Phương pháp debug có hệ thống

## Quy trình 5 bước

### 1. Reproduce
- Xác định steps để reproduce
- Minimal reproduction case

### 2. Isolate
- Thu hẹp phạm vi
- Binary search qua code

### 3. Analyze
- Đọc error messages kỹ
- Check logs
- Breakpoints

### 4. Fix
- Fix root cause, không patch symptoms
- Viết test case trước

### 5. Verify
- Reproduce không còn bug
- Không regression

## Debug Tools

| Tool | Purpose |
|------|---------|
| console.log | Quick inspection |
| debugger | Step-through |
| Chrome DevTools | Frontend |
| Node inspect | Backend |
| Logging | Production |

## Common Patterns
- Race condition → Add delays, check order
- Memory leak → Profile heap snapshots
- Null reference → Check data flow
