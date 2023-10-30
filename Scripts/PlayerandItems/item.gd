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
	print("trying to draw I guess ?")
	
func lineDraw(pos1: Vector3, pos2: Vector3, meshcolor = Color.LIGHT_BLUE, persist_s = 0.5):
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()

	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(pos1)
	immediate_mesh.surface_add_vertex(pos2)
	immediate_mesh.surface_end()
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = meshcolor

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
