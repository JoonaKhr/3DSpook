shader_type spatial;

uniform sampler2D noise;
uniform vec3 color;
uniform float emissionStrength;
uniform float movementStrength;

void fragment() {
	ALBEDO = color;
	EMISSION = color * emissionStrength;
}

void vertex() {
	float height = (texture(noise, VERTEX.xz + TIME * 0.1).x - 0.5) * movementStrength;
	float width = (texture(noise, VERTEX.xy + TIME * 0.1).z - 0.5) * movementStrength;
	VERTEX.y += height;
	VERTEX.z += width;
	VERTEX.x += width;
}
