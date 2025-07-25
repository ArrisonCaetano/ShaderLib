shader_type canvas_item;
uniform sampler2D st:hint_screen_texture;

uniform float amount:hint_range(1.0, 10.0, 0.1)=1.0;


void fragment() {
    vec2 uv = SCREEN_UV;
	vec2 frac = fract(uv*amount);
   
    COLOR = texture(st, frac);
}
