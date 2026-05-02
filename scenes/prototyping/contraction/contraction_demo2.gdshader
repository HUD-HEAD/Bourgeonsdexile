//Adapted from Eindacor_DS : https://www.shadertoy.com/view/DtfBRf

shader_type canvas_item;

#define TWOPI 6.28318530718f

uniform float circleRadius : hint_range(0.0, 1.0, 0.1) = 0.5f;
uniform float lineWidth : hint_range(0.0, 0.1, 0.001) = 0.01f;
uniform float waves : hint_range(0.0, 50, 1) = 5.0f;
uniform float amplitude : hint_range(0.0, 1.0, 0.01) = 0.1f;
uniform float speed : hint_range(0.0, 100.0, 0.1) = 0.4f;

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
	float waviness = amplitude * circleRadius;
	
	//Make circle display at constant size on screen
	vec2 resolution = 1.0/SCREEN_PIXEL_SIZE.xy;
 	vec2 uv = FRAGCOORD.xy/resolution.xy;
    float aspectRatio = resolution.x / resolution.y;
    uv.x += ((.5 / aspectRatio) - .5);
    uv.x *= aspectRatio;

	//Consistent across screen resolutions
	float AA = 2.0/resolution.y;
	
    vec2 center  = vec2(.5);
    float distFromCenter = distance(uv, center);
    
    float radialVal = getRadialVal(center, uv);
    
    float localRadialVal = mod(radialVal, 1. / waves) * waves;
    
    float distCheck1 = circleRadius + waviness * sin(localRadialVal * TWOPI + TIME*speed);
    
	
	//Make wave more random
	vec2 delta = center.xy - FRAGCOORD.xy;
	float ang = atan(delta.y, delta.x)*0.01;
	
	float rand_offset = random(vec2(ang));
	float distCheck2 = circleRadius + waviness * sin(localRadialVal * TWOPI * 2.0 + TIME*speed*0.5*ang);
	float distCheck3 = circleRadius + waviness * sin(localRadialVal * TWOPI * 2.0 - TIME*speed*0.5*ang);

    
	float distCheck = distCheck1 + distCheck2 + distCheck3;
	//Divide by number of distchecks
	distCheck /= 3.0;
	
    float waveVal = 0.;
    if (distFromCenter > distCheck) {
        float outerEdge = distCheck + lineWidth * .5;
        waveVal = smoothstep(outerEdge + AA, outerEdge - AA, distFromCenter);
    } else {
        float innerEdge = distCheck - lineWidth * .5;
        waveVal = smoothstep(innerEdge - AA, innerEdge + AA, distFromCenter);
		//waveVal = 0.5;
    }
    
    COLOR = vec4(waveVal);
}


