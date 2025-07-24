shader_type canvas_item;
render_mode unshaded;

// Controls the vertical position of the wave dissolve cutoff
uniform float cutoff : hint_range(0.5, 1.0);

// Controls how tall the wave ripple is
uniform float wave_size : hint_range(0.0, 1.0) = 0.1;

// Controls how wide each wave ripple is
uniform float wave_frequency : hint_range(0.0, 0.1) = 0.04;

// Controls the animation speed of the wave
uniform float wave_speed : hint_range(0.0, 30.0) = 20.0;

// Controls the foam thickness at the edge of the wave
uniform float wave_foam_size : hint_range(0.0, 0.1) = 0.01;

// Color of the foam (the glowing/white edge of the wave)
uniform vec4 foam_color : source_color;

// Color shown above the wave cutoff line (main visible area)
uniform vec4 main_color : source_color = vec4(1.0);

void fragment()
{
    // Calculate a vertical reference value based on UV and wave size
    float value = (1.0 + UV.y) * (0.5 - wave_size);

    float alpha = 1.0;               // Default alpha is fully visible
    vec3 color = main_color.rgb;    // Default color is the base/main color

    // Calculate a wave animation based on time and horizontal position
    float wave_cutoff_percent = sin((SCREEN_UV.x / wave_frequency + TIME * wave_speed) + 1.0) / 2.0;

    // Final dynamic cutoff value
    float wave_cutoff_value = cutoff - wave_cutoff_percent * wave_size;

    // If the current pixel is below the cutoff line...
    if (value < wave_cutoff_value)
    {
        // If within foam threshold, apply foam color
        if (value > wave_cutoff_value - wave_foam_size)
        {
            color = foam_color.rgb;
        }
        else
        {
            // Otherwise, make it fully transparent (cut away)
            alpha = 0.0;
        }
    }

    COLOR = vec4(color, alpha);
}
