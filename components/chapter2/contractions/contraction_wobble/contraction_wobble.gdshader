//Adapted from Eindacor_DS : https://www.shadertoy.com/view/DtfBRf

shader_type canvas_item;

#define USE_TEXTURE false

#define TWOPI 6.28318530718f

uniform float circleRadius : hint_range(0.0, 1.0, 0.1) = 0.5f;
uniform float lineWidth : hint_range(0.0, 0.1, 0.001) = 0.01f;
uniform float waves : hint_range(0.0, 10, 1) = 5.0f;
uniform float amplitude : hint_range(0.0, 1.0, 0.01) = 0.1f;
uniform float speed : hint_range(0.0, 100.0, 0.1) = 0.4f;
uniform float offset_intensity : hint_range(0.0, 3.0, 0.1) = 1.0f;
uniform float blur_amount : hint_range(0, 5) = 5.0; // Strength of the blur effect

//Blur parameters
uniform sampler2D screen_texture: hint_screen_texture, repeat_disable, filter_linear_mipmap;

vec4 blur(vec2 screen_uv){
    // Color with blur effect from the screen
    vec4 blurColor = textureLod(screen_texture, screen_uv, blur_amount);

    // Mix colors of the blur effect with white for an additional effect
    //blurColor.rgb = mix(blurColor.rgb, vec3(1.0), 0.1);

    // Set the final color to the modified color of the blur effect
	return blurColor;
}


float random (vec2 uv) {
    return fract(sin(dot(uv.xy,
        vec2(12.9898,78.233))) * 43758.5453123);
}


float getOffsetAngle(vec2 first, vec2 second) {
    vec2 offsetVec = second - first;
    float angle = atan(offsetVec.y / offsetVec.x);
    
    if (first.x < second.x) {
        angle = TWOPI / 2.f + angle;
    } else if (first.y > second.y) {
        angle = TWOPI + angle;
    }
    
    return angle;
}

float getRadialVal(vec2 center, vec2 p) {
    float offsetAngle = getOffsetAngle(center, p);
    offsetAngle = mod(TWOPI - offsetAngle + 3.f * TWOPI / 6.f, TWOPI);
    return offsetAngle / TWOPI;
}

void fragment() {
	float time = TIME;
	float waviness = amplitude * circleRadius;
	
	#if !USE_TEXTURE
		//Make circle display at constant size on screen
		vec2 resolution = 1.0/SCREEN_PIXEL_SIZE.xy;
	 	vec2 uv = FRAGCOORD.xy/resolution.xy;
	    float aspectRatio = resolution.x / resolution.y;
	    uv.x += ((.5 / aspectRatio) - .5);
	    uv.x *= aspectRatio;
		//Consistent across screen resolutions
		//float AA = 2.0/resolution.y;
	#else
		//Make circle display relative to texture
		vec2 resolution = 1.0/TEXTURE_PIXEL_SIZE.xy;
	 	vec2 uv = UV;
	    float aspectRatio = TEXTURE_PIXEL_SIZE.y / TEXTURE_PIXEL_SIZE.x;
	    uv.x += ((.5 / aspectRatio) - .5);
	    uv.x *= aspectRatio;
		//TODO restore
		float AA = 0.0;
	#endif



	
    vec2 center  = vec2(.5);
    float distFromCenter = distance(uv, center);
    
    float radialVal = getRadialVal(center, uv);
    
    float localRadialVal = mod(radialVal, 1. / waves) * waves;
    
	float x = localRadialVal*TWOPI;
	//float deformation = cos(x+TIME)*(sin(x+TIME*1.8)*0.1 + 0.1);
	
    float distCheck1 = circleRadius + waviness * sin(x + time*speed);
    //distCheck1 = abs(cos(localRadialVal*12.)*sin(localRadialVal*3.))*.8+.1;
    //distCheck1 = abs(cos(localRadialVal*TWOPI)*sin(localRadialVal*TWOPI + 0.2))*.1+.1;
	
	//Make wave more random
	vec2 delta = center.xy - FRAGCOORD.xy;
	float ang = atan(delta.y, delta.x)*0.01;
	
	//float rand_offset = random(vec2(ang));
	
	
	//TODO FIX / rework
	//can't use base TIME value in offsetting, as offset will start at 0 on play and grow over time
	time = sin(TIME) + 100.0;
	
	float distCheck2 = circleRadius +  offset_intensity * waviness * sin(x* 2.0 + time*speed*ang/TWOPI + time*ang*10.0);
	float distCheck3 = circleRadius + offset_intensity * waviness * sin(x* 2.0 + time*speed - time*ang*0.5);

    
	float distCheck = distCheck1 + distCheck2 + distCheck3;
	//Divide by number of distchecks
	distCheck /= 3.0;
	
    float waveVal = 0.;
	
	vec4 new_color = vec4(1.0);
    if (distFromCenter > distCheck) {
		float outerEdge = distCheck + lineWidth * .5;
		if (distFromCenter > outerEdge){
			new_color = blur(SCREEN_UV);
		}else{
			new_color = vec4(1.0);
		}
    }else {
        float innerEdge = distCheck - lineWidth * .5;
        waveVal = smoothstep(innerEdge - AA, innerEdge + AA, distFromCenter);
		new_color = vec4(waveVal);
		COLOR.a *= waveVal;
		//waveVal = 0.5;
    }
    COLOR.rgb = new_color.rgb;
}
