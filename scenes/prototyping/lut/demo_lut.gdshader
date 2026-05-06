shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap;
uniform sampler3D lut ;

void fragment() {
	COLOR.rgb = texture(lut,texture(screen_texture, SCREEN_UV).rgb).rgb;
} 