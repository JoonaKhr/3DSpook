extends Node

@export var color: Color

# Called when the node enters the scene tree for the first time.
func _ready():
	get_child(0).material_override.albedo_color = color
	get_child(0).material_override.set_emission(get_parent().requiredColor)

