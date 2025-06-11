# Exploded 3D UI with Transform

This example demonstrates automatic DOM depth-based 3D layering using CSS transforms.

## How It Works

### Core CSS Concepts

1. **3D Context Setup**
   - `.viewport` sets `perspective: 1000px` to create 3D viewing space
   - `.ui-container` uses `transform-style: preserve-3d` to maintain 3D positioning

2. **Depth Level Classes**
   - `.level-0` through `.level-5` classes apply `translateZ()` transforms
   - Each level moves elements further along the Z-axis: 0px, 15px, 30px, 45px, 60px, 75px
   - Formula: `Z = Level × Spacing` (default spacing = 15px)

3. **Automatic Assignment**
   - JavaScript traverses the DOM tree and assigns level classes based on nesting depth
   - Root elements get `.level-0`, children get `.level-1`, grandchildren get `.level-2`, etc.

### Interactive Controls

- **Spacing**: Adjusts Z-distance between levels
- **Translation**: Moves the entire 3D scene on X, Y, Z axes  
- **Rotation**: Rotates the scene to view the layered effect
- **Debug Mode**: Colors each level for visual depth identification

### Key Features

- Elements maintain their 2D layout while gaining 3D depth
- Nested DOM structure automatically creates visual hierarchy
- Real-time controls for exploring the 3D space
- Debug visualization shows which elements are at each depth level

Open `index.html` in a browser and use "Apply Level Classes" to see the effect.