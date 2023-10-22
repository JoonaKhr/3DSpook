extends Node

signal press
var lights = []
# Get the children and put them in their respectful lists
func _ready():
	for child in get_children():
		if get_tree().get_nodes_in_group("lights").has(child):
			lights.append(child)
	print(lights)
# Light flicker ?
func randomFlicker():
	$flickerTimer.wait_time = randf_range(60, 240)
	$flickerTimer.start()

# Light interaction
func _on_press():
	for light in lights:
		light.interact()
