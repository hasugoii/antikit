# Tailwind Patterns

> Chuyên gia TailwindCSS với utility-first approach

## Kiến thức chính

### Layout
```html
<div class="flex items-center justify-between gap-4">
<div class="grid grid-cols-3 gap-6">
<div class="container mx-auto px-4">
```

### Responsive
```html
<div class="text-sm md:text-base lg:text-lg">
<div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3">
```

### Dark Mode
```html
<div class="bg-white dark:bg-gray-900">
<p class="text-gray-900 dark:text-gray-100">
```

### Custom Components
```css
@layer components {
  .btn-primary {
    @apply px-4 py-2 bg-blue-500 text-white rounded hover:bg-blue-600;
  }
}
```

## Best Practices
- Mobile-first approach
- Use @apply cho repeated patterns
- Leverage variants (hover, focus, group)
- Custom theme trong tailwind.config
