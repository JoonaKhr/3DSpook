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
	#print(lights)

# Light interaction
func _on_press():
	$sfx.play()
	for light in lights:
		if state:
			animationplayer.play_backwards("switch_toggle")
		else:
			animationplayer.play("switch_toggle")
		light.interact()
	state = !state