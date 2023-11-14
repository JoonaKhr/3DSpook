@tool
extends Node3D

var shader_location = self.mesh.surface_get_material(0).get_shader_param("location")
var contract_point:Node3D

func _ready():
	contract_point = $Node3D


func _process(delta):
	shader_location = contract_point.transform
