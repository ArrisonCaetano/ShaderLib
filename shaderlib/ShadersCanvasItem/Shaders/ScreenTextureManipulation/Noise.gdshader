shader_type canvas_item;

uniform float time;
uniform sampler2D st:hint_screen_texture;
float rand(vec2 co){
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

void fragment() {
    float noise = rand(SCREEN_UV * time);
    vec4 color = texture(st, SCREEN_UV);
    color.rgb += noise * 0.05;
    COLOR = color;
}