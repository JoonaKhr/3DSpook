shader_type spatial;

uniform vec3 location;

void fragment() {
	// Place fragment code here.
}

void vertex() {
	vec3 point_to_vertex_direction = normalize(location - VERTEX);
	float point_to_vertex_distance = distance(location, VERTEX);
	//VERTEX = point_to_vertex_direction * smoothstep(0, point_to_vertex_distance, point_to_vertex_distance);
	VERTEX += location;
}
