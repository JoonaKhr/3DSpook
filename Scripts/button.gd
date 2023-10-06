extends Node

signal press
signal flicked
var lights = []
# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		if child is OmniLight3D:
			lights.append(child)

	print(lights)

func randomFlicker():
	$flickerTimer.wait_time = randf_range(60, 240)
	$flickerTimer.start()

func _on_press():
	for light in lights:
		if light.visible:
			light.visible = false
		else:
			randomFlicker()
			light.visible = true	


func _on_flicker_timer_timeout():
	var light = lights.pick_random()
	if light.visible:
		light.visible = false