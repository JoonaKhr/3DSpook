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

func randomFlicker():
	$flickerTimer.wait_time = randf_range(5, 100)

func _on_press():
	for light in lights:
		if light.visible:
			light.visible = false
		else:
			light.visible = true	


func _on_flicker_timer_timeout():
	var light = lights.pick_random()
	if light.visible:
		light.visible = false
	else:
		light.visible = true
