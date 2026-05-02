//Adapted from Eindacor_DS : https://www.shadertoy.com/view/DtfBRf

shader_type canvas_item;

#define AA .002f
#define TWOPI 6.28318530718f

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
	//Make circle display at constant size on screen
	vec2 resolution = 1.0/SCREEN_PIXEL_SIZE.xy;
 	vec2 uv = FRAGCOORD.xy/resolution.xy;
    float aspectRatio = resolution.x / resolution.y;
    uv.x += ((.5 / aspectRatio) - .5);
    uv.x *= aspectRatio;

    vec2 center  = vec2(.5);
    
    float distFromCenter = distance(uv, center);
    
    float circleRadius = 0.4f;
    float waviness = circleRadius * .03;
    
    float radialVal = getRadialVal(center, uv);
    
    float waves = 24.;
    
    float localRadialVal = mod(radialVal, 1. / waves) * waves;
    
    float distCheck = circleRadius + waviness * sin(localRadialVal * TWOPI);
    
    float lineWidth = circleRadius * .5;
    
    float waveVal = 0.;
    if (distFromCenter > distCheck) {
        float outerEdge = distCheck + lineWidth * .5;
        waveVal = smoothstep(outerEdge + AA, outerEdge - AA, distFromCenter);
    } else {
        float innerEdge = distCheck - lineWidth * .5;
        waveVal = smoothstep(innerEdge - AA, innerEdge + AA, distFromCenter);
    }
    
    COLOR = vec4(waveVal);
    //COLOR = vec4(waveVal, waveVal, waveVal, 1.0);
	//COLOR = vec4(1.0);
}


