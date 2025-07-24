shader_type canvas_item;

// This uniform controls how fast the sine wave animation moves over time
uniform float speed = 1.5;

// This uniform controls how far (in pixels) the vertices will move horizontally
uniform float amplitude = 100.0;


void vertex() {
    // This condition checks if the current vertex is below the horizontal center line (y < 0.0)
    // In a Sprite, this usually means the bottom half of the rectangle.
    if (VERTEX.y < 0.0) {
        // If true, shift the vertex horizontally using a sine wave
        // The shift changes over time (TIME * speed), and the amount is scaled by 'amplitude'
        VERTEX += vec2(sin(TIME * speed) * amplitude, 0);
    }

}
