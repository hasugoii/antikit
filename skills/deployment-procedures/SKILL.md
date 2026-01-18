# Deployment Procedures

> Quy trình deploy an toàn

## Pre-deployment Checklist

```
[ ] Tests passing
[ ] Build successful
[ ] Environment variables set
[ ] Database migrations ready
[ ] Rollback plan documented
[ ] Monitoring configured
```

## Deployment Strategies

### Blue-Green
```
Blue (current) → Green (new)
Switch traffic when ready
Rollback = switch back
```

### Rolling Update
```
Update instances one by one
Zero downtime
Gradual rollout
```

### Canary
```
Deploy to 5% users
Monitor metrics
Gradual increase
```

## Post-deployment

```
[ ] Health check passing
[ ] Monitor error rates
[ ] Check performance
[ ] Verify critical paths
```
