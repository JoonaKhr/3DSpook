extends Node

signal press
var lights = []
var doors = []
# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		if get_tree().get_nodes_in_group("lights").has(child):
			lights.append(child)
		if get_tree().get_nodes_in_group("doors").has(child):
			doors.append(child)

	print(lights)
	print(doors)

func randomFlicker():
	$flickerTimer.wait_time = randf_range(60, 240)
	$flickerTimer.start()

func _on_press():
	for light in lights:
		light.interact()
	for door in doors:
		door.interact()	
