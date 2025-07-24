shader_type canvas_item;

// Controls the strength of the RGB split effect.
// The range is limited to a small value to avoid excessive distortion.
uniform float intensity : hint_range(0.0, 0.05) = 0.005;

// Determines the direction of the color channel shift (e.g., horizontal or vertical).
uniform vec2 direction = vec2(1.0, 0.0); // Effect direction (X, Y)

// The screen texture is used to sample the current screen contents.
uniform sampler2D screen_tex : hint_screen_texture;

void fragment() {
    // Get the current fragment's UV coordinates relative to the screen.
    vec2 uv = SCREEN_UV;

    // Calculate the distance from the center of the screen.
    float dist = distance(SCREEN_UV, vec2(0.5));

    // Emphasize the distance effect (quadratic falloff) and scale it up.
    dist = (dist * dist) * 3.0;

    vec4 col;

    // Apply a directional offset to the red channel.
    // This creates the chromatic aberration (RGB split) effect by shifting red.
    col.r = texture(screen_tex, uv + direction * intensity * dist).r;

    // Keep the green channel unchanged (sample at original UV).
    col.g = texture(screen_tex, uv).g;

    // Apply the opposite directional offset to the blue channel.
    // This balances the effect, pulling blue in the opposite direction of red.
    col.b = texture(screen_tex, uv - direction * intensity * dist).b;

    // Set full opacity for the output color.
    col.a = 1.0;

    // Assign the final color to the output.
    COLOR = col;
}
