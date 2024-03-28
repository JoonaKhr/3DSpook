extends Node3D

@export var iname = ""
@export var activated = false
@export var color: Color
#Does nothing yet
@export_enum("Blue","Green","Yellow","Orange","Purple","Gun","Hand") var item_type

var original_position: Vector3
var player
var electricityMat = preload("res://Resources/Materials/m_gunElectricity.tres")

signal press
signal activate

func _ready():
	original_position = position
	player = get_tree().get_nodes_in_group("player")[0]
	if activated == false:
		visible = false
	if self.has_node("Mesh2"):
		$Mesh2.material_override.albedo_color = color

#Pickup item if holding nothing at all ( nothing at all~ )
func pickupItem():
	print("Picked up: ", iname)
	player.inventory.obtainItem(self)

func _process(_delta):
	#manage gun ammo display
	if self.has_node("ammo"):
		match Player.vars["ammo"]:
			4:
				$ammo.set_region_rect(Rect2(0,0,32,32))
			3:
				$ammo.set_region_rect(Rect2(0,32,32,32))
			2:
				$ammo.set_region_rect(Rect2(0,64,32,32))
			1:
				$ammo.set_region_rect(Rect2(0,96,32,32))
			0:
				$ammo.set_region_rect(Rect2(0,128,32,32))

func shoot(target):
	if activated == true:
		if Player.vars["ammo"] > 0:
			var barrel = $Marker3D.global_position
			var targetPoint = target["position"]
			lineDraw(barrel, targetPoint)
			$shoot.play()

			#manage ammo (impressive I know)
			Player.vars["ammo"] -= 1
		else:
			pass
	#print("trying to draw I guess ?")
	
func lineDraw(from: Vector3, to: Vector3, persist_s = 0.1):
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var directionVector = (to - from).normalized();
	var playerDirection = player.transform.basis.x * -1.0
	var vertexDistance = 0.05
	var stripThickness = 0.01
	var amountOfVertexes = int(from.distance_to(to) / vertexDistance)
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_TRIANGLE_STRIP, electricityMat)
	for i in amountOfVertexes:
		var shift = (Vector3(playerDirection.x * (i % 2), 0, playerDirection.z * (i % 2))).normalized()
		immediate_mesh.surface_add_vertex(from + directionVector * i * vertexDistance + shift * stripThickness)
		immediate_mesh.surface_set_normal(Vector3(0, -1, 0))
	for i in amountOfVertexes:
		var shift = (Vector3(playerDirection.x * (i % 2), 0, playerDirection.z * (i % 2))).normalized()
		immediate_mesh.surface_add_vertex(from + directionVector * (amountOfVertexes - i) * vertexDistance + shift * stripThickness)
		immediate_mesh.surface_set_normal(Vector3(0, 1, 0))
	immediate_mesh.surface_end()
	#print(mesh_instance.mesh.surface_get_arrays(0))
	#print(get_parent().get_parent().get_parent().transform.basis)

	get_tree().get_root().add_child(mesh_instance)
	if persist_s:
		await get_tree().create_timer(persist_s).timeout
		mesh_instance.queue_free()
	else:
		return mesh_instance


# Use item on target currently only useful for keycards
func useItem(target):
	if get_tree().get_nodes_in_group("reader").has(target) and activated == true:
		target.readkeycard(self)

func _on_press():
	pickupItem()

func _on_activate():
	visible = true
	activated = true
