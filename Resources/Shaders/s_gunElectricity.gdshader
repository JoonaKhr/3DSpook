shader_type spatial;

uniform sampler2D noise;
uniform vec3 color;
uniform float emissionStrength;

void fragment() {
	ALBEDO = color;
	EMISSION = color * emissionStrength;
}

void vertex() {
	float height = texture(noise, VERTEX.xz + TIME).x - 0.5;
	float width = texture(noise, VERTEX.xy + TIME).z - 0.5;
	VERTEX.y += height;
	VERTEX.z += width;
	//VERTEX.x += width;
}
