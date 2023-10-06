extends Node

signal press
signal flicked
var lights = []
var doors = []
# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		if child is Node3D:
			lights.append(child)
		if child is StaticBody3D:
			doors.append(child)

	print(lights)

func randomFlicker():
	$flickerTimer.wait_time = randf_range(60, 240)
	$flickerTimer.start()

func _on_press():
	for light in lights:
		light.activate()	
