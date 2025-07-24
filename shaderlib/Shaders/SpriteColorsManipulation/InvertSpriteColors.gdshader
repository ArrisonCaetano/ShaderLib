// Define the shader type. `canvas_item` is used for 2D rendering (like sprites, UI elements, etc.)
shader_type canvas_item;

// Declare a uniform sampler2D (a 2D texture input). The hint `hint_default_black` means
// that if no texture is provided, it defaults to black.
uniform sampler2D tex : hint_default_black;

// Declare a boolean uniform that allows the user to toggle color inversion.
uniform bool invertcolors;

void fragment() {
    // Sample the texture at the current UV coordinates.
    vec4 col = texture(tex, UV);

    // Calculate the inverted color by subtracting the RGB values from 1.
    // The alpha (transparency) is left unchanged.
    vec4 invertedColor = vec4(1.0 - col.rgb, col.a);

    // If the `invertcolors` uniform is true, apply the inverted color.
    if (invertcolors) {
        COLOR = vec4(invertedColor); // Set the final output color.
    }

    // If `invertcolors` is false, nothing is drawn because COLOR is not set.
    // To fix this, you can set COLOR = col as a fallback, like this:
    // else {
    //     COLOR = col;
    // }
}
