# MCP Builder

> Xây dựng Model Context Protocol servers

## MCP Structure

```
mcp-server/
├── src/
│   ├── index.ts      # Entry point
│   ├── tools/        # Tool definitions
│   └── resources/    # Resource handlers
├── package.json
└── tsconfig.json
```

## Tool Definition

```typescript
const tool = {
  name: "search_files",
  description: "Search for files in directory",
  inputSchema: {
    type: "object",
    properties: {
      query: { type: "string" },
      directory: { type: "string" }
    },
    required: ["query"]
  }
};

async function handleTool(name: string, args: any) {
  if (name === "search_files") {
    return searchFiles(args.query, args.directory);
  }
}
```

## Resources

```typescript
const resource = {
  uri: "file:///path/to/file",
  name: "config.json",
  mimeType: "application/json"
};
```

## Best Practices

- Clear tool descriptions
- Input validation
- Error handling
- Proper logging
