shader_type canvas_item;

// A textura da tela com filtro linear para suavizar
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear;

// Controla inversão: 1 = ativado, 0 = desativado para evitar boleans
uniform int invertcolors : hint_range(0, 1);

void fragment() {
    // Pega a cor da tela na posição atual
    vec4 screen_color = texture(SCREEN_TEXTURE, SCREEN_UV);

    // Cor invertida (RGB invertido, alfa igual)
    vec3 inverted_rgb = 1.0 - screen_color.rgb;

    // Convertendo o int para float para usar no mix
    float inv = float(invertcolors);

    // Interpola entre cor original e invertida baseado no valor de inv (0 ou 1)
    vec3 final_rgb = mix(screen_color.rgb, inverted_rgb, inv); // usando mix como um if

    // Define a cor final do fragmento
    COLOR = vec4(final_rgb, screen_color.a);
}
