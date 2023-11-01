extends Node3D

@export var iname = ""
@export var descrip = ""
@export var color: Color
signal press

func _ready():
	if self.has_node("Mesh2"):
		$Mesh2.material_override.albedo_color = color

#Pickup item if holding nothing at all ( nothing at all~ )
func pickupItem():
	print("Picked up: ", iname)
	get_parent().get_node("Player").inventory.obtainItem(self)

func shoot(target):
	var barrel = $Marker3D.global_position
	var targetPoint = target["position"]
	lineDraw(barrel, targetPoint)
	#print("trying to draw I guess ?")
	
func lineDraw(from: Vector3, to: Vector3, meshcolor = Color.LIGHT_BLUE, persist_s = 0.1):
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := load("res://Resources/Materials/m_gunElectricity.tres")
	var directionVector = (to - from).normalized();
	var playerDirection = get_parent().get_parent().get_parent().transform.basis.z
	var vertexDistance = 0.05
	var stripThickness = 0.02
	var amountOfVertexes = int(from.distance_to(to) / vertexDistance)
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_TRIANGLE_STRIP, material)
	for i in amountOfVertexes:
		var shift = (Vector3(0, 0, i % 2) * playerDirection).normalized()
		immediate_mesh.surface_add_vertex(from + directionVector * i * vertexDistance + shift * stripThickness)
		immediate_mesh.surface_set_normal(Vector3(0, -1, 0))
	for i in amountOfVertexes:
		var shift = (Vector3(0, 0, i % 2) * playerDirection).normalized()
		immediate_mesh.surface_add_vertex(from + directionVector * (amountOfVertexes - i) * vertexDistance + shift * stripThickness)
		immediate_mesh.surface_set_normal(Vector3(0, 1, 0))
	immediate_mesh.surface_end()
	#print(mesh_instance.mesh.surface_get_arrays(0))
	#material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	#material.albedo_color = meshcolor
	#print(get_parent().get_parent().get_parent().transform.basis)

	get_tree().get_root().add_child(mesh_instance)
	if persist_s:
		await get_tree().create_timer(persist_s).timeout
		mesh_instance.queue_free()
	else:
		return mesh_instance


# Use item on target currently only useful for keycards
func useItem(target):
	if get_tree().get_nodes_in_group("reader").has(target):
		target.readkeycard(self)
	print("Trying to use item ", iname, " on ", target)

func _on_press():
	pickupItem()
