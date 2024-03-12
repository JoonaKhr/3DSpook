@tool
extends Node3D

var contract_point:Node3D

func _ready():
	contract_point = $Node3D


func _process(_delta):
	self.mesh.surface_get_material(0).set_shader_parameter("location", contract_point.position)
