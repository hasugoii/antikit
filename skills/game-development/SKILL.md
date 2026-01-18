# Game Development

> Patterns cho phát triển game

## Game Loop

```typescript
function gameLoop(timestamp) {
  const delta = timestamp - lastTime;
  
  processInput();
  update(delta);
  render();
  
  requestAnimationFrame(gameLoop);
}
```

## Entity Component System

```typescript
// Entities are IDs
// Components are data
// Systems process entities with specific components

const renderSystem = (entities) => {
  entities.forEach(e => {
    if (e.has('position') && e.has('sprite')) {
      draw(e.sprite, e.position.x, e.position.y);
    }
  });
};
```

## Common Systems

- Physics (velocity, collision)
- Rendering (sprites, animations)
- Input (keyboard, mouse, touch)
- AI (pathfinding, state machines)

## Libraries

- Phaser (2D web games)
- Three.js (3D)
- Matter.js (physics)
- Howler.js (audio)
