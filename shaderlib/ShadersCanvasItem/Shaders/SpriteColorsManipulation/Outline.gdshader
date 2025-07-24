shader_type canvas_item;

// Texture the aura is applied to
uniform sampler2D tex : hint_default_black;

// Time for animation (can be passed via script or replaced with TIME)
uniform float time;

// Aura edge thickness
uniform float aura_thickness = 0.01;

// Aura strength/intensity
uniform float aura_strength = 1.0;

// Pulse speed
uniform float pulse_speed = 3.0;

// Aura color
uniform vec4 aura_color : source_color = vec4(1.0, 0.6, 0.2, 1.0);

// Function to apply a pulsating aura around the visible edges of a texture
vec4 apply_aura(vec2 uv_coords, sampler2D texture_input, float anim_time, float edge_thickness, float glow_strength, float pulse_rate, vec4 glow_color) {
    float center_alpha = texture(texture_input, uv_coords).a;
    float edge_detected = 0.0;
    float step_size = edge_thickness;

    // 3x3 sampling around the current UV to detect transparent neighbors (edge detection)
    for (float x = -1.0; x <= 1.0; x++) {
        for (float y = -1.0; y <= 1.0; y++) {
            vec2 offset = vec2(x, y) * step_size;
            float neighbor_alpha = texture(texture_input, uv_coords + offset).a;

            // If neighbor is transparent and center is opaque, mark as edge
            if (neighbor_alpha < 0.1 && center_alpha > 0.1) {
                edge_detected = 1.0;
            }
        }
    }

    // Pulsating intensity based on time
    float pulse = sin(anim_time * pulse_rate) * 0.5 + 0.5;

    // Sample base texture color
    vec4 base_color = texture(texture_input, uv_coords);

    // Calculate aura contribution
    vec4 aura = glow_color * pulse * glow_strength * edge_detected;

    // Final color blend
    vec4 final_color = base_color + aura;
    final_color.a = base_color.a; // Preserve original alpha

    return final_color;
}

void fragment() {
    COLOR = apply_aura(UV, tex, TIME, aura_thickness, aura_strength, pulse_speed, aura_color);
}
