shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, filter_nearest;
uniform sampler2D palette_texture;
uniform vec4 shadow_colour : source_color;
uniform float y_offset : hint_range(0, 2);
uniform int palette_size = 8;

uniform bool is_debug = false;

int get_palette_index(vec4 color) {
    ivec4 quantized_color = ivec4(floor(color * 255.0 + 0.5)); // Quantize the color

    for (int i = 0; i < palette_size; i++) {
        float index = (float(i) + 0.5) / float(palette_size); // Sample at the center of each color slot
        vec4 palette_color = texture(palette_texture, vec2(index, 0.0));

        ivec4 quantized_palette = ivec4(floor(palette_color * 255.0 + 0.5)); // Quantize the palette color

        if (quantized_color == quantized_palette) {
            return i; // Found exact match
        }
    }

    return -1; // No match found
}

void fragment() {
    vec4 screen_color = texture(screen_texture, SCREEN_UV);

    // Check if the color is close to the shadow colo

    int palette_index;

    palette_index = get_palette_index(screen_color);

    // Normalize the palette index for UV lookup
    if (palette_index != -1) {
        float palette_uv_x = (float(palette_index) + 0.5) / float(palette_size);
        float palette_uv_y = (float(y_offset) + 0.5) / float(3);
        COLOR = texture(palette_texture, vec2(palette_uv_x, palette_uv_y));
    } else {
        // Fallback if no match (this should only happen if no matching palette index is found)
		if (is_debug)
		{
			COLOR = texture(palette_texture, vec2(float(palette_size), 0.0));
		} else
		{
			COLOR = screen_color;
		}
    }
}
