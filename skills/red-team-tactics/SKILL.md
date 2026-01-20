# Red Team Tactics

> Kỹ thuật tấn công để test bảo mật

## Attack Categories

### Injection
```
SQL: ' OR '1'='1
XSS: <script>alert('xss')</script>
Command: ; cat /etc/passwd
```

### Authentication
```
Brute force passwords
Session hijacking
Token manipulation
```

### Authorization
```
IDOR: /api/users/123 → /api/users/124
Privilege escalation
Role bypass
```

## Testing Flow

1. Reconnaissance (gather info)
2. Scanning (find entry points)
3. Exploitation (attempt attacks)
4. Post-exploitation (assess impact)
5. Reporting (document findings)

## Tools

- Burp Suite
- OWASP ZAP
- sqlmap
- nmap

## CVSS Scoring

```
Critical: 9.0-10.0
High: 7.0-8.9
Medium: 4.0-6.9
Low: 0.1-3.9
```
