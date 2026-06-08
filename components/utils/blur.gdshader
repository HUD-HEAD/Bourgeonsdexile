shader_type canvas_item;

#define TWOPI 6.28318530718f

//Blur parameters
uniform sampler2D screen_texture: hint_screen_texture, repeat_disable, filter_linear_mipmap;
uniform float blur_amount : hint_range(0, 5) = 5.0; // Strength of the blur effect

vec4 blur(vec2 screen_uv){
    // Color with blur effect from the screen
    vec4 blurColor = textureLod(screen_texture, screen_uv, blur_amount);

    // Set the final color to the modified color of the blur effect
	return blurColor;
}

void fragment() {
	vec4 new_color = blur(SCREEN_UV);
    COLOR.rgb = new_color.rgb;
}