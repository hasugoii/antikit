# Server Management

> Quản lý server và infrastructure

## SSH

```bash
ssh user@host
ssh -i key.pem user@host
scp file user@host:/path
```

## Nginx

```nginx
server {
  listen 80;
  server_name example.com;
  
  location / {
    proxy_pass http://localhost:3000;
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection 'upgrade';
    proxy_set_header Host $host;
  }
}
```

## Systemd Service

```ini
[Unit]
Description=My App
After=network.target

[Service]
User=www-data
WorkingDirectory=/app
ExecStart=/usr/bin/node /app/index.js
Restart=always

[Install]
WantedBy=multi-user.target
```

## Monitoring

- htop / top
- logs: journalctl, /var/log
- disk: df -h
- memory: free -h
