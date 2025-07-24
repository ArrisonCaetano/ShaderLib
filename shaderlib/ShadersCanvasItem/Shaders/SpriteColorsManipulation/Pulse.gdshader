shader_type canvas_item;

// Texture to apply the pulsating glow to
uniform sampler2D tex : hint_default_black;

// Time uniform for animation (can be set from code or replaced with TIME)
uniform float time;

// Speed of the pulse animation
uniform float speed = 2.0;

// Strength of the glow effect
uniform float strength = 1.0;

// Color of the pulsating glow
uniform vec4 glow_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);

// Function that applies pulsating glow to a texture
vec4 apply_pulseglow(vec2 uv_coords, sampler2D texture_input, float anim_time, float pulse_speed, float glow_strength, vec4 pulse_color) {
    vec4 base_color = texture(texture_input, uv_coords);

    // Generate a pulse that oscillates between 0.0 and 1.0
    float pulse = sin(anim_time * pulse_speed) * 0.5 + 0.5;

    // Multiply pulse by glow color and strength
    vec4 glow = pulse_color * pulse * glow_strength;

    // Combine base color with glow
    vec4 final_color = base_color + glow;

    // Preserve alpha
    final_color.a = base_color.a;

    return final_color;
}

void fragment() {
    // Output the result of the pulsating glow effect
    COLOR = apply_pulseglow(UV, tex, TIME, speed, strength, glow_color);
}
