shader_type canvas_item;

// Base texture
uniform sampler2D tex : hint_default_black;

// Time for animation (can be passed manually or replaced with TIME)
uniform float time;

// Intensity of the freeze effect (0.0 = no effect, 1.0 = full freeze)
uniform float freeze_intensity = 1.0;

// Speed of the shimmer animation
uniform float shimmer_rate = 4.0;

// Function that applies a freezing shimmer effect over the texture
vec4 apply_freeze_effect(vec2 uv_coords, sampler2D texture_input, float anim_time, float freeze_strength, float shimmer_speed) {
    vec4 base_color = texture(texture_input, uv_coords);

    // Tint toward icy blue/white for frozen look
    vec3 cold_tone = mix(base_color.rgb, vec3(0.8, 0.9, 1.0), 0.7);

    // Animated shimmer using sine wave on vertical axis + time
    float shimmer = sin((uv_coords.y + anim_time * shimmer_speed) * 20.0) * 0.1 + 0.1;

    // Blend the base color with shimmered frozen tone based on intensity
    vec3 blended_color = mix(base_color.rgb, cold_tone + shimmer, freeze_strength);

    return vec4(blended_color, base_color.a);
}

void fragment() {
    COLOR = apply_freeze_effect(UV, tex, TIME, freeze_intensity, shimmer_rate);
}
