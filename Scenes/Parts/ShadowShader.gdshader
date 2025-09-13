shader_type canvas_item;

uniform vec4 shadow_colour;

uniform bool allow_transparency = true;

void fragment() {
	COLOR = vec4(shadow_colour.r, shadow_colour.g, shadow_colour.b, COLOR.a * (shadow_colour.a * float(allow_transparency || COLOR.a == 1.0)));
}