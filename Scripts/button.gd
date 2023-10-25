extends StaticBody3D

signal press
var lights = []
@onready var animationplayer = $AnimationPlayer
@export var state: bool

# Get the children and put them in their respectful lists
func _ready():
	animationplayer.set_assigned_animation("switch_toggle")
	if state:
		animationplayer.advance(0.2)
	else:
		animationplayer.advance(0.0)
	for child in get_children():
		if child.has_method("interact"):
			lights.append(child)
	print(lights)
# Light flicker ?
func randomFlicker():
	$flickerTimer.wait_time = randf_range(60, 240)
	$flickerTimer.start()

# Light interaction
func _on_press():
	for light in lights:
		if state:
			state = false
			animationplayer.play_backwards("switch_toggle")
		else:
			state = true
			animationplayer.play("switch_toggle")
		light.interact()
