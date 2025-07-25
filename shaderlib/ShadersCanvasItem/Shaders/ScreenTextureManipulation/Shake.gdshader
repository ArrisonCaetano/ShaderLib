shader_type canvas_item;

// A textura da tela com filtro linear para suavizar
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear;

// Controla inversão: 1 = ativado, 0 = desativado para evitar boleans
uniform int invertcolors : hint_range(0, 1);
uniform float intensity:hint_range(0.0, .009, 0.001) =  .01;

void fragment() {

	vec2 uv = SCREEN_UV;
	
	uv += vec2(sin(TIME * 50.0), cos(TIME * 40.0)) * intensity;
    // Pega a cor da tela na posição atual
    vec4 screen_color = texture(SCREEN_TEXTURE, uv);

    // Cor invertida (RGB invertido, alfa igual)
    vec3 fx = screen_color.rgb;

    // Convertendo o int para float para usar no mix
    float inv = float(invertcolors);

    // Interpola entre cor original e invertida baseado no valor de inv (0 ou 1)
    vec3 final_rgb = mix(screen_color.rgb, fx, inv); // usando mix como um if

    // Define a cor final do fragmento
    COLOR = vec4(final_rgb, screen_color.a);
}
