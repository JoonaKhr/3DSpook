shader_type spatial;

uniform sampler2D noise;

void fragment() {
	ALBEDO = texture(noise, UV).rgb;
}

void vertex() {
	vec2 sines = abs(sin((VERTEX.xz) * (4.0 - sin(VERTEX.xz))+ 1.5) * sin(TIME) * sin(VERTEX.xz) * 0.6);
	float position = sines.x * sines.y;
	VERTEX.y = position;
}
