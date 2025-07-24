shader_type canvas_item;

uniform sampler2D tex: hint_default_black;
uniform vec4 tintcolor: source_color = vec4(0.8,0.4,0.2,1.0);
uniform float mixamount: hint_range(0.0, 10.0, 0.1) = 1.0;

void fragment() {
	
	vec4 newtex = texture(tex,UV);
	COLOR = (newtex *tintcolor)* mixamount;
}

