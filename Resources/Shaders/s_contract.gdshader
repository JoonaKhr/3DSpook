shader_type spatial;

uniform vec3 location;

void fragment() {
	// Place fragment code here.
}

void vertex() {
	vec3 direction_to_vertex = normalize(VERTEX - location);
	float distance_to_point = distance(location, VERTEX);
	
	vec3 contraction = direction_to_vertex * distance_to_point * smoothstep(0.4, 0.7, distance_to_point);
	VERTEX = contraction;
}
