# WORKFLOW: /ak-report - 举报软件包

> **Context:** Agent `@security`
> **Required Skills:** `reporting`

---

## 阶段1：识别软件包

```
/ak-report skill/suspicious-tool
```

---

## 阶段2：选择原因

```
🚩 举报软件包

软件包: skill/suspicious-tool
作者: @unknown_user

您为什么要举报此软件包？
1️⃣ 安全问题（恶意软件、数据盗窃）
2️⃣ 不当内容
3️⃣ 质量低 / 无法工作
4️⃣ 其他
```

---

## 阶段3：提供详情

```
📝 描述问题：
> 此软件包似乎会将 API 密钥发送到外部服务器
```

---

## 阶段4：提交

```
✅ 举报已提交

📊 软件包状态：
├── 举报: 3/3 (已达阈值！)
├── 状态: 🔒 已自动隔离
└── 维护者已收到通知

感谢您帮助保护 AntiKit 社区！
```

---

## ⚠️ 下一步：
```
1️⃣ /ak-browse - 查看其他软件包
2️⃣ /ak-update - 检查更新
3️⃣ 返回工作
```
