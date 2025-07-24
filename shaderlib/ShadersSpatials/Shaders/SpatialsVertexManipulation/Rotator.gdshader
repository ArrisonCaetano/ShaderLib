// Define the shader type. `spatial` is used for 3D rendering.
shader_type spatial;

// Disable backface culling so both sides of the mesh are visible.
render_mode cull_disabled;

// Uniforms for rotation angles around X, Y, and Z axes.
// These values will be passed from the material or script (in radians).
uniform float x;
uniform float y;
uniform float z;

// === Rotation Matrix Around the X Axis ===
mat3 rotateX(float theta) {
    float cosa = cos(theta);
    float sina = sin(theta);

    // Rotation matrix around X axis:
    // | 1    0       0   |
    // | 0   cos   -sin |
    // | 0   sin    cos |
    mat3 rotate_x = mat3(
        vec3(1.0, 0.0, 0.0),
        vec3(0.0, cosa, -sina),
        vec3(0.0, sina, cosa)
    );
    
    return rotate_x;
}

// === Rotation Matrix Around the Y Axis ===
mat3 rotateY(float theta) {
    float cosa = cos(theta);
    float sina = sin(theta);

    // Rotation matrix around Y axis:
    // | cos   0   sin |
    // |  0    1    0  |
    // |-sin   0   cos |
    mat3 rotate_y = mat3(
        vec3(cosa, 0.0, sina),
        vec3(0.0, 1.0, 0.0),
        vec3(-sina, 0.0, cosa)
    );
    
    return rotate_y;
}

// === Rotation Matrix Around the Z Axis ===
mat3 rotateZ(float theta) {
    float cosa = cos(theta);
    float sina = sin(theta);

    // Rotation matrix around Z axis:
    // | cos  -sin  0 |
    // | sin   cos  0 |
    // |  0     0   1 |
    mat3 rotate_z = mat3(
        vec3(cosa, -sina, 0.0),
        vec3(sina,  cosa, 0.0),
        vec3(0.0,   0.0,  1.0)
    );
    
    return rotate_z;
}

// === Vertex Shader Function ===
void vertex() {
    // Combine the rotation matrices in X, Y, Z order.
    mat3 rotation_matrix = rotateX(x) * rotateY(y) * rotateZ(z);

    // Apply the combined rotation to the vertex position.
    vec3 rotated_vertex = rotation_matrix * VERTEX;

    // Apply the same rotation to the normal vector for correct lighting.
    vec3 rotated_normals = rotation_matrix * NORMAL;

    // Override the built-in vertex and normal with the rotated versions.
    VERTEX = rotated_vertex;
    NORMAL = rotated_normals;
}
