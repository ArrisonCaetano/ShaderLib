// This is a 2D shader, used for sprites, UI, etc.
shader_type canvas_item;

// Texture input. Defaults to black if no texture is assigned.
uniform sampler2D tex : hint_default_black;

// === 2D Rotation Function ===
// Rotates a UV coordinate around a given pivot point by an angle (in radians).
vec2 rotate(vec2 uv, vec2 pivot, float angle) {
    // Build a 2D rotation matrix.
    mat2 rotation = mat2(
        vec2(sin(angle), -cos(angle)),
        vec2(cos(angle),  sin(angle))
    );

    // Move UV to be relative to the pivot (usually the center)
    uv -= pivot;

    // Apply rotation
    uv = uv * rotation;

    // Move UV back to original position
    uv += pivot;

    // Return the rotated UV
    return uv;
}

// === Fragment Shader ===
// Runs for every pixel of the object using this material
void fragment() {
    // Rotate the current UV coordinate around the center (0.5, 0.5)
    // Angle is based on TIME, so it rotates over time
    vec2 rotated_uv = rotate(UV, vec2(0.5), TIME);

    // Sample the texture at the rotated UV position
    vec4 newTex = texture(tex, rotated_uv);

    // Set the final pixel color to the sampled value
    COLOR = vec4(newTex);
}
