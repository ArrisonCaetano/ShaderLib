shader_type canvas_item;

// Outer circle radius with a range hint for editor UI.
// Controls the size of the outermost circle.
uniform float radius_1 : hint_range(0.0, 0.5) = 0.406;

// Controls how much the outer circle radius pulses (animates).
uniform float pulse_range : hint_range(0.0, 0.2) = 0.012;

// Speed of the pulsing animation (frequency of radius changes).
uniform float pulse_speed : hint_range(0.0, 100.0) = 20.0;

// Softness controls the smoothness of the outer circle’s edge.
uniform float softness_1 : hint_range(0.01, 0.2) = 0.2;

// Color of the outermost circle (default: cyan-ish blue).
uniform vec4 color_1 : source_color = vec4(0.0, 0.63, 0.86, 1.0);

// Radius of the middle circle, between outer and inner.
uniform float radius_mid : hint_range(0.0, 0.5) = 0.22;

// Softness of the middle circle edge.
uniform float softness_mid : hint_range(0.01, 0.2) = 0.01;

// Color of the middle circle (a lighter blue).
uniform vec4 color_mid : source_color = vec4(0.35, 0.75, 0.96, 1.0);

// Radius of the innermost circle.
uniform float radius_2 : hint_range(0.0, 0.5) = 0.153;

// Softness of the inner circle edge.
uniform float softness_2 : hint_range(0.01, 0.2) = 0.023;

// Color of the innermost circle (yellowish-white).
uniform vec4 color_2 : source_color = vec4(0.94, 0.905, 0.80, 1.0);

// Function to create a smooth circular mask with soft edges.
// Returns a value between 0 and 1 representing the circle’s alpha at the UV position.
float circle_soft(vec2 uv, vec2 center, float radius, float softness) {
    // Calculate distance from the current UV to the circle center.
    float dist = distance(uv, center);
    
    // Use smoothstep to create a soft edge around the circle radius.
    // The transition happens between radius-softness and radius+softness.
    return 1.0 - smoothstep(radius - softness, radius + softness, dist);
}

void fragment() {
    // Current UV coordinates (usually normalized screen or texture coords).
    vec2 uv = UV;
    
    // Define the circle center at the middle of the UV space.
    vec2 center = vec2(0.5);

    // Animate the outer radius using a sine wave based on TIME and pulse speed.
    // This makes the outer circle pulse smoothly.
    float pulse = sin(TIME * pulse_speed) * pulse_range;
    float animated_radius = radius_1 + pulse;

    // Calculate smooth masks for each circle layer using the soft circle function.
    float outer = circle_soft(uv, center, animated_radius, softness_1);
    float mid = circle_soft(uv, center, radius_mid, softness_mid);
    float inner = circle_soft(uv, center, radius_2, softness_2);

    // Initialize the output color to transparent black.
    vec4 col = vec4(0.0);

    // Blend the outer color based on the outer mask.
    col = mix(col, color_1, outer);
    
    // Blend the middle color on top of the previous color using the middle mask.
    col = mix(col, color_mid, mid);
    
    // Finally, blend the inner color on top with the inner mask.
    col = mix(col, color_2, inner);

    // Output the final color for this fragment.
    COLOR = col;
}
