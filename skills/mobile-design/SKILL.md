# Mobile Design

> Thiết kế cho mobile apps

## Touch Targets

- Minimum 44x44px tap areas
- Adequate spacing between targets
- Bottom navigation for primary actions

## Navigation Patterns

- Tab bar (bottom)
- Drawer (hamburger)
- Stack navigation
- Modal presentation

## React Native Components

```tsx
import { View, Text, TouchableOpacity, FlatList } from 'react-native';

<FlatList
  data={items}
  renderItem={({ item }) => <ItemCard item={item} />}
  keyExtractor={item => item.id}
/>
```

## Performance

- Use FlatList, not ScrollView for lists
- Optimize images
- Lazy load screens
- Native animations (Reanimated)

## Platform Specifics

| iOS | Android |
|-----|---------|
| Safe areas | Status bar |
| Gestures | Back button |
| Apple HIG | Material Design |
