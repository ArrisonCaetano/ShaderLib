shader_type canvas_item;

uniform sampler2D st : hint_screen_texture;

void fragment() {
    vec2 uv = SCREEN_UV;
    uv.y = uv.y; // Inverte verticalmente
    COLOR = texture(st, uv);
}