extends Node

signal press
var lights = []

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		if child is OmniLight3D:
			lights.append(child)

	print(lights)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_press():
	for light in lights:
		if light.visible:
			light.visible = false
		else:
			light.visible = true	
