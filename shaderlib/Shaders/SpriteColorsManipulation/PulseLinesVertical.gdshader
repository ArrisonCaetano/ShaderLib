shader_type canvas_item;

// The texture to apply the effect to
uniform sampler2D tex : hint_default_black;

// Time-related uniform to animate the effect
uniform float time;

// Speed of the moving pulse lines
uniform float speed = 1.0;

// Width of the glowing stripe (0.0 to 1.0 range)
uniform float width = 0.1;

// Color of the glowing pulse lines
uniform vec4 glow_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);

// Function that applies pulse lines over a base texture
vec4 apply_pulselines(vec2 uv_coords, sampler2D texture_input, float anim_time, float pulse_speed, float stripe_width, vec4 pulse_color) {
    vec4 base_color = texture(texture_input, uv_coords);

    // Creates a diagonal sine wave pattern that moves with time
    float glow = sin((uv_coords.x + uv_coords.y + anim_time * pulse_speed) * 10.0);

    // Smooth glowing stripe based on sine value
    float stripe = smoothstep(1.0 - stripe_width, 1.0, glow);

    // Add the glowing color over the base
    vec4 final_color = base_color + pulse_color * stripe;

    // Preserve original alpha
    final_color.a = base_color.a;

    return final_color;
}

void fragment() {
    // Apply the pulse line effect and output the final color
    COLOR = apply_pulselines(UV, tex, TIME, speed, width, glow_color);
}
