shader_type canvas_item;


uniform sampler2D st : hint_screen_texture;

// Controle de intensidade do glitch (ex: 0.0 a 1.0)
uniform float glitch_strength : hint_range(0.0, 1.0) = 0.5;
// Controle da velocidade do glitch
uniform float glitch_speed : hint_range(0.0, 10.0) = 1.0;

float rand(vec2 co){
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

void fragment() {
    vec2 uv = SCREEN_UV;

    float line = floor(uv.y * 240.0);

    // Aplica glitch_speed multiplicando o time
    float timeSpeed = TIME * glitch_speed;

    // Intensidade do deslocamento multiplicada por glitch_strength
    float glitchAmount = 0.02 * glitch_strength * sin(timeSpeed * 20.0 + line * 10.0) * step(0.8, rand(vec2(line, timeSpeed)));

    float block = step(0.95, rand(vec2(floor(line / 5.0), timeSpeed)));
    float glitchBlockOffset = glitchAmount * 5.0 * block;

    uv.x += glitchAmount + glitchBlockOffset;

    float chromaOffset = 0.005 * glitch_strength;
    vec2 uvR = uv + vec2(chromaOffset, 0.0);
    vec2 uvG = uv;
    vec2 uvB = uv - vec2(chromaOffset, 0.0);

    float r = texture(st, uvR).r;
    float g = texture(st, uvG).g;
    float b = texture(st, uvB).b;

    vec3 color = vec3(r, g, b);

    float noise = rand(uv * timeSpeed * 100.0);
    float flicker = step(0.99, noise);

    color += flicker * 0.2 * glitch_strength;

    COLOR = vec4(color, 1.0);
}
