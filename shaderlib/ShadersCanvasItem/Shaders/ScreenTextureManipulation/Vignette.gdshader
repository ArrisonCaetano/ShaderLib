shader_type canvas_item;


uniform sampler2D st :hint_screen_texture;
uniform float power = 1.5;
uniform float radius = 0.6;
void fragment() {
    vec2 uv = SCREEN_UV - vec2(0.5);
    float len = length(uv);
    float vignette = smoothstep(radius, power, len);
    COLOR = texture(st, SCREEN_UV) * (1.0 - vignette);
}