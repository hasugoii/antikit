# NestJS Expert

> Chuyên gia NestJS framework

## Project Structure

```
src/
├── modules/
│   └── users/
│       ├── users.module.ts
│       ├── users.controller.ts
│       ├── users.service.ts
│       └── dto/
│           └── create-user.dto.ts
├── common/
│   ├── guards/
│   └── interceptors/
└── main.ts
```

## Core Concepts

```typescript
// Controller
@Controller('users')
export class UsersController {
  @Post()
  create(@Body() dto: CreateUserDto) {}
  
  @Get(':id')
  findOne(@Param('id') id: string) {}
}

// Service
@Injectable()
export class UsersService {
  constructor(private prisma: PrismaService) {}
}

// Module
@Module({
  controllers: [UsersController],
  providers: [UsersService],
})
export class UsersModule {}
```

## Best Practices

- Use DTOs with class-validator
- Custom exception filters
- Guards for auth
- Interceptors for logging
