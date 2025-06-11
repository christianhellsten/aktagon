# T3D CSS 3D Transform Component

A lightweight CSS component for creating animated 2D to 3D layer transformations.

## Basic Usage

1. **HTML Structure**: Wrap your layers in the required containers with proper classes
2. **Activation**: Add the `.is-3d` class to trigger the 3D transformation
3. **Customization**: Adjust CSS variables to modify timing and positioning

## Required HTML Structure

```html
<div class="t3d-viewport">
  <div class="t3d-scene">
    <div class="t3d-layer" data-depth="1">Content 1</div>
    <div class="t3d-layer" data-depth="2">Content 2</div>
    <div class="t3d-layer" data-depth="3">Content 3</div>
  </div>
</div>
```

## Activation

Trigger the 3D transformation by adding the state class:

```javascript
// Activate 3D mode
document.querySelector(".t3d-viewport").classList.add("is-3d");

// Deactivate (return to 2D)
document.querySelector(".t3d-viewport").classList.remove("is-3d");
```

## Customization Variables

```css
:root {
  --t3d-duration: 5s; /* Animation duration */
  --t3d-scene-distance: -200px; /* Scene depth positioning */
  --t3d-scene-tilt: 71deg; /* Downward tilt angle */
  --t3d-scene-rotation: -10deg; /* Left/right rotation */
  --t3d-scene-skew: 60deg; /* Diagonal orientation */
  --t3d-layer-base: 20px; /* First layer depth */
  --t3d-layer-increment: 30px; /* Depth between layers */
}
```

## Complete Example

```html
<div class="card-stack">
  <div class="t3d-viewport">
    <div class="t3d-scene">
      <div class="t3d-layer" data-depth="1">
        <h3>Front Card</h3>
        <p>This appears closest to the viewer</p>
      </div>
      <div class="t3d-layer" data-depth="2">
        <h3>Middle Card</h3>
        <p>This is positioned behind the front card</p>
      </div>
      <div class="t3d-layer" data-depth="3">
        <h3>Back Card</h3>
        <p>This appears furthest from the viewer</p>
      </div>
    </div>
  </div>
  <button onclick="toggleTransform()">Toggle 3D</button>
</div>

<script>
  function toggleTransform() {
    const viewport = document.querySelector(".t3d-viewport");
    viewport.classList.toggle("is-3d");
  }
</script>
```

## Notes

- Layers are positioned absolutely and stacked in 2D initially
- The `data-depth` attribute determines the layer's 3D positioning
- Animation respects `prefers-reduced-motion` accessibility setting
- All layers should have the same dimensions for best visual effect

