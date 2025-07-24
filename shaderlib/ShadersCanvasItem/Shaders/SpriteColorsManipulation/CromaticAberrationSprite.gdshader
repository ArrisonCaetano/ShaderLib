shader_type canvas_item;

// Texture to apply the glitch effect to
uniform sampler2D tex : hint_default_black;

// Time for animation (can be set via script or replaced with TIME)
uniform float time;

// How far the RGB channels split
uniform float split_amount = 0.01;

// Speed of the glitch animation
uniform float glitch_speed = 10.0;

// Function for applying RGB glitch split
vec4 apply_glitch_rgb_split(vec2 uv_coords, sampler2D texture_input, float anim_time, float split_strength, float speed_factor) {
    // Calculate the offset using sine and cosine to create a jittery effect
    float offset_x = sin(anim_time * speed_factor) * split_strength;
    float offset_y = cos(anim_time * speed_factor * 1.3) * split_strength;

    // Sample each color channel from slightly offset UVs
    float r = texture(texture_input, uv_coords + vec2(offset_x, 0.0)).r;
    float g = texture(texture_input, uv_coords + vec2(0.0, offset_y)).g;
    float b = texture(texture_input, uv_coords - vec2(offset_x, offset_y)).b;
    float a = texture(texture_input, uv_coords).a;

    // Combine the split RGB values into one final color
    return vec4(r, g, b, a);
}

void fragment() {
    // Apply glitch RGB split and output result
    COLOR = apply_glitch_rgb_split(UV, tex, TIME, split_amount, glitch_speed);
}
