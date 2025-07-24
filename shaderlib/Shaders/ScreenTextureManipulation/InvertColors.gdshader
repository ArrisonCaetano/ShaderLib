shader_type canvas_item;

// Accesses the screen texture (what is currently rendered on screen).
// 'filter_linear' ensures smooth texture sampling.
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear;

// A boolean flag to toggle color inversion on or off.
uniform bool invertcolors;

void fragment() {
    // Samples the current color at this fragment's screen position.
    vec4 screen_color = texture(SCREEN_TEXTURE, SCREEN_UV);

    // If inversion is enabled, invert the RGB channels.
    if(invertcolors) {
        // Invert each RGB channel by subtracting from 1.0.
        // Alpha remains unchanged.
        COLOR = vec4(1.0 - screen_color.rgb, screen_color.a);	
    } else {
        // If not inverting, just output the original screen color.
        COLOR = vec4(screen_color);
    }
}
