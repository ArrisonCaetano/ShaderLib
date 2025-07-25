shader_type canvas_item;

uniform float strength = 0.0;
uniform sampler2D st:hint_screen_texture;

void fragment() {
    vec2 uv = SCREEN_UV - vec2(0.5);
    float angle = strength * sin(TIME + length(uv) * 12.0);
    float s = sin(angle);
    float c = cos(angle);
    uv = mat2(vec2(c, -s),vec2( s, c)) * uv;
	
    COLOR = texture(st, uv + vec2(0.5));
}
