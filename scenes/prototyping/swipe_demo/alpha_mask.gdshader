shader_type canvas_item;

uniform sampler2D texture_albedo : source_color;

void fragment() {
	COLOR.a = COLOR.a * texture(texture_albedo,UV).a;
}