shader_type spatial;
render_mode unshaded;

// Controla a frequência das ondas
uniform float amount : hint_range(0.0, 100.0, 0.01) = 20.0;

// Controla a intensidade geral da distorção
uniform float move = 1.0;

// Altura base das faixas senoidais
uniform float bandsize = 0.1;

// Velocidade de movimento das ondas
uniform float speed = 1.0;

void vertex() {
    // Centraliza UV para criar efeito simétrico
    vec2 uv = UV - 0.5;

    // Adiciona movimento com o tempo
    uv.y += TIME * speed;

    // Calcula valor senoidal animado
    float wave = sin(uv.y * amount) + bandsize;

    // Aplica distorção ao longo da normal da esfera
    VERTEX += NORMAL * wave * move;
}

void fragment() {
    // Centraliza UV para manter padrão igual ao vertex shader
    vec2 uv = UV - 0.5;

    // Anima as ondas no eixo Y
    uv.y += TIME * speed;

    // Cria a mesma função senoidal para desenhar o padrão
    float wave = sin(uv.y * amount) + bandsize;

    // Define a cor da faixa com base no valor senoidal
    ALBEDO = vec3(wave);
}
