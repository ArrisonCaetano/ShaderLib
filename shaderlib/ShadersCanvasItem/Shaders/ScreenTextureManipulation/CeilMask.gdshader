shader_type canvas_item;
render_mode unshaded;

// Textura base em escala de cinza (pontos brancos em fundo escuro, por exemplo)
uniform sampler2D mask_texture : repeat_enable;

// Controla quantos pontos da textura vão aparecer
// 0.0 = nenhum ponto visível, 1.0 = todos os pontos visíveis
uniform float mask_threshold : hint_range(0.0, 1.0, 0.01) = 1.0;

void fragment() {
    // Pega o valor de brilho (0.0 a 1.0) da textura no ponto atual
    float tex_value = texture(mask_texture, UV).r;

    // Define uma máscara binária (0 ou 1), com base na intensidade e no controle do usuário
    float mask = ceil(tex_value - 1.0 + mask_threshold);

    // Mostra branco onde a máscara é 1, preto onde é 0
    COLOR = vec4(vec3(mask), 1.0);
}
